WITH UserInformation AS (SELECT 
	IFNULL((SELECT id FROM wp_users WHERE user_login = 'TestUser'), 'NotAnUser') AS resultfound)
	SELECT 
		'TestUser' AS username,
		CASE 
			WHEN UserInformation.resultfound = 'NotAnUser' THEN 'NotRegisteredUser'
			WHEN EXISTS (
				SELECT 1 
				FROM wp_usermeta 
				WHERE meta_key LIKE 'wp_%_capabilities' OR meta_key = 'wp_capabilities'
					AND user_id = (SELECT id FROM wp_users WHERE user_login = 'TestUser')
			) THEN wp_blogs.blog_id
			ELSE 'NoContent'
		END AS blog_id,
		CASE 
			WHEN UserInformation.resultfound = 'NotAnUser' THEN 'NotRegisteredUser'
			WHEN EXISTS (
				SELECT 1 
				FROM wp_usermeta 
				WHERE meta_key LIKE 'wp_%_capabilities' 
					AND user_id = (SELECT id FROM wp_users WHERE user_login = 'TestUser')
			) THEN 
				CONCAT('https://', wp_blogs.domain, wp_blogs.path)
			ELSE 'NoContent'
		END AS url, 
		CASE
			WHEN UserInformation.resultfound = 'NotAnUser' THEN 'NotRegisteredUser'
			WHEN EXISTS (
				SELECT 1 
				FROM wp_sitemeta 
				WHERE meta_key = 'site_admins' AND meta_value LIKE CONCAT('%"', 'TestUser', '"%')
			) THEN 'Y'
			ELSE 'N'
		END AS is_super_admin
	FROM UserInformation
	LEFT JOIN wp_blogs ON wp_blogs.blog_id IN (
		SELECT SUBSTRING(meta_key, 4, LENGTH(meta_key)-16) 
		FROM wp_usermeta 
		WHERE meta_key LIKE 'wp_%_capabilities' 
			AND user_id = (SELECT id FROM wp_users WHERE user_login = 'TestUser')
	);