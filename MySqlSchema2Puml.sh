##
# usage:
# $0 <DbSchemaName>
##

# Including configs
my_dir="$(dirname "$0")"
. "$my_dir/config.sh"

dbSchema=$1
echo '@startuml

!define table(x) class x << (T,#FFAAAA) >>
!define primary_key(x) <u>x</u>
hide methods
hide stereotypes' >> $outFile

listTablesQ="SELECT    CONCAT_ws(' ', 'class', TABLE_NAME) as \"'Tables Follow:\" FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE   WHERE   TABLE_SCHEMA = '$dbSchema';"
listRelationsQ="SELECT CONCAT(TABLE_NAME, ' \"n\" --* \"1\" ',REFERENCED_TABLE_NAME) as \"'Relatins Follow:\" FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE  TABLE_SCHEMA = '$dbSchema' AND REFERENCED_TABLE_NAME IS NOT NULL;"

mysql -u $dbUser $usePw -h $dbHost -e "$listTablesQ $listRelationsQ" >> $outFile

echo "@enduml" >> $outFile

cat $outFile

