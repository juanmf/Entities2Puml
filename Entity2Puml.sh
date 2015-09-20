#!/bin/bash
##
# This script aims to generate a puml file describing your Doctrine data model. 
# Then you just parse the directory where the output file is with plantuml.jar 
# and it renders the Class Model for you.
#
# Usage:
#
# @param projectRoot/src A parent Directory where Entities reside might be as 
#                        narrow as Bundle/Entity/ or as wide as project root.
# @param outputFile.puml [Optional] the desired output filename for plantUml 
#                        diagram source
#
# $0 projectRoot/src [outputFile.puml]
##

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

# end configs

rm $defaultOutFile

if [ -z "$2" ]; then
    outFile=$defaultOutFile
else
    outFile=$2
fi

entities=$(grep --exclude="*~" --include="$scannedFilesPattern" -RlP $entityAnnotation $1 )
echo "@startuml" >> $outFile
echo "" >> $outFile

# Adding all Entities
echo "' Entities follows:" >> $outFile

for i in $entities
do echo class $(echo ${i/$scannedFilesExtension/} | xargs -I '{p}' basename '{p}') "{" >> $outFile
    # Adding attributes if enabled by $includeAttrs
    if $includeAttrs ; then
        attrs=$(awk '/class/,/function\s+\w+\(/' $i  | grep -P "^\s+(private|public|protected)\s+\\$" | grep -oP '\$[^\s=;]*')
        for attr in $attrs; 
            do echo "    $attr" >> $outFile 
        done

    fi
    echo "}" >> $outFile
done

echo "" >> $outFile
echo "' Relations follows:" >> $outFile

for i in $entities
do
    for relationType in "ManyToMany" "OneToOne" "ManyToOne"
    do
        relations=$(awk '/class/,/function\s+\w+\(/' $i |  awk "/$relationType/,/\)/" | awk '/targetEntity="/,/"/' | grep -oP 'targetEntity="[^"]+"')
        if [ -n "$relations" ]
        then
            for relation in $relations
            do
                relatedEntity=${relation/targetEntity=/}
                # Still have to eliminate namespace in order to match class name with file names ($i)
                relatedEntity=$(echo $relatedEntity | grep -Po '\w+(?=\")')
                if [ "$relationType" == "ManyToOne" ] 
                then
                    arrow=' "n" --* "1" '
                elif [ "$relationType" == "OneToOne" ]
                then
                    arrow=' "1" --* "1" '
                elif [ "$relationType" == "ManyToMany" ]
                then
                    arrow=' "n" --o "n" '
                fi
                echo $(echo ${i/$scannedFilesExtension/} | xargs -I '{p}' basename '{p}') $arrow $relatedEntity >> $outFile
            done

        fi
    done
done

echo "@enduml" >> $outFile
cat $outFile 
