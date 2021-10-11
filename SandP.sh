#!/bin/bash
set -e
echo "First take a backup of database"
echo "Provide Database Name"
read databasename < /dev/tty

echo  "Database Username"
read username < /dev/tty

echo "Database Password"
read password < /dev/tty

echo "Taking backup now ..."
mysqldump -u $username -p$password $databasename > ../private_html/backup.sql


echo "Backup has been created and placed in the private_html"

echo "Provide the Domain that is needed to replaced"
read varprimary < /dev/tty

echo "Provide the Domain to be replaced"
read varsecondary < /dev/tty

echo "Running Dry Run"
wp search-replace $varprimary $varsecondary --all-tables --dry-run


echo Do you want to continue[yes/no]?
read ANSWER < /dev/tty

if [ -z "$ANSWER" ]; then
        echo "There is no answer."
        exit
fi

if [ "$ANSWER" = "yes" ]; then
        echo "Running Search and Replace."
wp search-replace '$varprimary' '$varsecondary' --all-tables
wp cache flush
        echo "Search and Replaced completed"
        echi "Cache has been flush"
        exit

elif [ "$ANSWER" = "no" ]; then
        echo "Process terminated!"
        exit
else
        echo "Wrong Answer! Bye."

fi
