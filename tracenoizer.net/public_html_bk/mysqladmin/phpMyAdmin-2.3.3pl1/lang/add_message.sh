#!/bin/bash
# $Id: add_message.sh,v 1.5 2002/08/10 04:19:33 robbat2 Exp $
#
# Shell script that adds a message to all message files (Lem9)
#
# Example:  add_message.sh '$strNewMessage' 'new message contents'
#
for file in *.inc.php3
do
        echo $file " "
        grep -v '?>' ${file} > ${file}.new
        echo "$1 = '"$2"';  //to translate" >> ${file}.new
        echo "?>" >> ${file}.new
        rm $file
        mv ${file}.new $file
done
echo " "
echo "Message added to add message files (including english)"
