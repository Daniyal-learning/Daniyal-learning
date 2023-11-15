#!/bin/bash

# Loop through each WordPress installation
for wp_path in /home/master/applications/*/public_html; do
    # Check if the malcare-security plugin directory exists
    if [ -d "$wp_path/wp-content/plugins/malcare-security" ]; then
        # Get the database name
        db_name=$(cd "$wp_path" && wp db query "SELECT DATABASE()" --skip-plugins --skip-themes --allow-root --silent 2>/dev/null)

        # Get the WordPress site URL from options table
        site_url=$(cd "$wp_path" && wp option get siteurl --skip-plugins --skip-themes --allow-root --format=json 2>/dev/null)

        # Print the results
        echo "WordPress Installation: $wp_path"
        echo "malcare-security Plugin: Installed and Active"
        echo "Database Name: $db_name"
        echo "Site URL: $site_url"
        echo "--------------------------------------"
    fi
done
