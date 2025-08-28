Deno.serve(async (req) => {
    const corsHeaders = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
        'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE, PATCH',
        'Access-Control-Max-Age': '86400',
        'Access-Control-Allow-Credentials': 'false'
    };

    if (req.method === 'OPTIONS') {
        return new Response(null, { status: 200, headers: corsHeaders });
    }

    try {
        // Only allow POST method for reordering
        if (req.method !== 'POST') {
            throw new Error('Method not allowed');
        }

        const { projectOrders } = await req.json();

        console.log('Project reorder request received:', { 
            projectOrdersCount: projectOrders?.length 
        });

        // Validate request data
        if (!projectOrders || !Array.isArray(projectOrders) || projectOrders.length === 0) {
            throw new Error('Project orders array is required and must not be empty');
        }

        // Validate each project order item
        for (const item of projectOrders) {
            if (!item.id || typeof item.sort_order !== 'number') {
                throw new Error('Each project order must have id and sort_order fields');
            }
            if (item.sort_order < 0) {
                throw new Error('Sort order must be non-negative');
            }
        }

        // Get environment variables
        const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY');
        const supabaseUrl = Deno.env.get('SUPABASE_URL');

        if (!serviceRoleKey || !supabaseUrl) {
            throw new Error('Supabase configuration missing');
        }

        console.log('Environment variables validated, processing reorder...');

        // Verify user authentication
        const authHeader = req.headers.get('authorization');
        if (!authHeader) {
            throw new Error('Authorization header required');
        }

        const token = authHeader.replace('Bearer ', '');
        
        // Verify token and get user
        const userResponse = await fetch(`${supabaseUrl}/auth/v1/user`, {
            headers: {
                'Authorization': `Bearer ${token}`,
                'apikey': serviceRoleKey
            }
        });

        if (!userResponse.ok) {
            throw new Error('Invalid authentication token');
        }

        const userData = await userResponse.json();
        console.log('User authenticated:', userData.id);

        // Verify all project IDs exist before updating
        const projectIds = projectOrders.map(item => item.id);
        const projectsResponse = await fetch(`${supabaseUrl}/rest/v1/projects?select=id&id=in.(${projectIds.join(',')})`, {
            headers: {
                'Authorization': `Bearer ${serviceRoleKey}`,
                'apikey': serviceRoleKey,
                'Content-Type': 'application/json'
            }
        });

        if (!projectsResponse.ok) {
            const errorText = await projectsResponse.text();
            throw new Error(`Failed to verify projects: ${errorText}`);
        }

        const existingProjects = await projectsResponse.json();
        if (existingProjects.length !== projectIds.length) {
            throw new Error('Some project IDs do not exist');
        }

        console.log('All project IDs verified, performing bulk update...');

        // Perform bulk update using atomic transactions
        const updatePromises = projectOrders.map(async ({ id, sort_order }) => {
            const response = await fetch(`${supabaseUrl}/rest/v1/projects?id=eq.${id}`, {
                method: 'PATCH',
                headers: {
                    'Authorization': `Bearer ${serviceRoleKey}`,
                    'apikey': serviceRoleKey,
                    'Content-Type': 'application/json',
                    'Prefer': 'return=minimal'
                },
                body: JSON.stringify({
                    sort_order,
                    updated_at: new Date().toISOString()
                })
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(`Failed to update project ${id}: ${errorText}`);
            }

            return { id, sort_order };
        });

        // Execute all updates
        const results = await Promise.all(updatePromises);
        
        console.log('Project reordering completed successfully:', {
            updatedCount: results.length
        });

        const result = {
            data: {
                success: true,
                updated_projects: results,
                message: `Successfully reordered ${results.length} projects`
            }
        };

        return new Response(JSON.stringify(result), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });

    } catch (error) {
        console.error('Project reordering error:', error);

        const errorResponse = {
            error: {
                code: 'PROJECT_REORDER_FAILED',
                message: error.message,
                timestamp: new Date().toISOString()
            }
        };

        return new Response(JSON.stringify(errorResponse), {
            status: 500,
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
        });
    }
});