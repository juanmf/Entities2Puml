#!/bin/bash
##
# Global configs
##

##
# The defaul output filename in case second argument is not given
##
defaultOutFile="/tmp/tempUml.puml"

##
# end Global configs
##

##
# Including configs
##

my_dir="$(dirname "$0")"
. "$my_dir/config_doctrine.sh"
. "$my_dir/config_mysql.sh"

##
# end Including configs
##

rm $defaultOutFile

if [ -z "$2" ]; then
    outFile=$defaultOutFile
else
    outFile=$2
fi

