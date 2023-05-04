#!/bin/bash

# Define colors for printing
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Redis server is running
if ! command -v redis-cli &>/dev/null || ! redis-cli ping &>/dev/null; then
    echo "Redis is not installed or the server is not running. Exiting..."
    exit 1
fi

# Check if the user is root
if [ $(id -u) -eq 0 ]; then
  allow_root="--allow-root"
else
  allow_root=""
fi

# Initialize variables
total_apps=0
connected_apps=0

# Get a list of all WordPress apps
apps=$(find /home/master/applications/*/public_html -name wp-config.php -exec dirname {} \;)

# Loop through each app and check Redis status
for app in $apps
do
    ((total_apps++)) # Increment total_apps counter
    echo -n "Checking Redis status for app $total_apps: "
    # Change directory to the app directory
    cd "$app" 2>/dev/null

    # Get the app name using wp-cli
    app_name=$(wp option get blogname $allow_root 2>/dev/null)

    # Get the app domain using wp-cli
    app_domain=$(wp option get siteurl $allow_root 2>/dev/null | awk -F/ '{print $3}')

    # Run the wp redis info command and filter for the status line
    status=$(wp redis info $allow_root 2>/dev/null | grep -w "Status")

    # Check if Redis is connected
    if [[ $status == "Status: Connected" ]]; then
        ((connected_apps++)) # Increment connected_apps counter
        # Print "Status: Connected" in green color
        echo -e "\033[32mStatus: Connected\033[0m"
    else
        # Print "Status: Not Connected" in red color
        echo -e "\033[31mStatus: Not Connected\033[0m"
    fi

    echo ""
done 2>/dev/null

# Calculate the number of remaining apps
remaining_apps=$((total_apps - connected_apps))

# Print the summary
echo "Total WordPress apps: $total_apps"
echo "Connected to Redis: $connected_apps"
echo "Remaining: $remaining_apps"
