#!/bin/bash

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
        echo "Search and Replaced completed!"
        exit

elif [ "$ANSWER" = "no" ]; then
        echo "Process terminated!"
        exit
else
        echo "Wrong Answer! Bye."

fi
