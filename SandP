#!/bin/bash

echo "Provide the Domain that is needed to replaced"
read varprimary <&1

echo "Provide the Domain to be replaced"
read varsecondary <&1

echo "Running Dry Run"
wp search-replace $varprimary $varsecondary --all-tables --dry-run


echo Do you want to continue[yes/no]?
read ANSWER <&1

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
