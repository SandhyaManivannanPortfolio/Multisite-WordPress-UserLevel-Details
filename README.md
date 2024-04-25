# SQL Query Overview

This SQL query is designed to extract user-level details in a WordPress multisite environment. It specifically targets a user, identified as 'TestUser' in this case, and retrieves their associated information across multiple sites.

## Key Components

1. **User Verification**: The query first verifies if 'TestUser' exists in the `wp_users` table of the WordPress database.

2. **User Role Identification**: If the user exists, the query checks the `wp_usermeta` table to identify the roles and capabilities associated with the user across different sites.

3. **Site Information Extraction**: For each site where the user has a role, the query retrieves the site's ID and URL from the `wp_blogs` table.

4. **Super Admin Check**: The query also checks if the user is a super admin by looking at the `wp_sitemeta` table.

## Output

The query returns a table with the following columns for 'TestUser':

- `username`: The username of the user.
- `blog_id`: The ID of the blog where the user has a role.
- `url`: The URL of the blog where the user has a role.
- `is_super_admin`: A flag indicating whether the user is a super admin ('Y' for yes, 'N' for no).

If 'TestUser' does not exist or has no roles on any site, appropriate messages are returned in the respective columns.

## Note

This query is specific to WordPress's database structure and may not work with other CMSs or custom database structures. Also, replace 'TestUser' with the actual username you want to check. 

