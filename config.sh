#!/bin/bash
##
# configs
##
##
# Whether or not to include Class' attributes in diagram
##
includeAttrs=true

##
# The regex that is used by `grep -P` to identify Entity classes
##
entityAnnotation='\@[^\\(]+\\(Entity|MappedSuperclass)'

##
# Filename pattern to include in search its used by `grep --include=PATTERN`.
##
scannedFilesPattern="*.php"

##
# Filename extension to strip from filename, used for classname assumption.
##
scannedFilesExtension=".php"

##
# The defaul output filename in case second argument is not given
##
defaultOutFile="/tmp/tempUml.puml"

##
# The defaul output filename in case second argument is not given
##
dbUser="root"

##
# The defaul output filename in case second argument is not given
##
usePw="-p "

##
# The defaul output filename in case second argument is not given
##
dbHost="localhost"

# end configs


rm $defaultOutFile

if [ -z "$2" ]; then
    outFile=$defaultOutFile
else
    outFile=$2
fi

