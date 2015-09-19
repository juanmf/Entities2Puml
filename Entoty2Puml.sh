#!/bin/bash

# configs
includeAttrs=true
# end configs

rm /tmp/tempUml

if [ -z "$2" ]; then
    outFile="/tmp/tempUml"
else
    outFile=$2
fi

entities=$(ls --ignore="*Repository*" $1)
echo "@startuml" >> $outFile
echo "" >> $outFile

# Adding all Entities
echo "' Entities follows:" >> $outFile

for i in $entities
    do echo class ${i/.php/} "{" >> $outFile
    # Adding attributes if enabled by $includeAttrs
    if $includeAttrs ; then
        attrs=$(awk '/class/,/function\s+\w+\(/' $1/$i  | grep -P "^\s+(private|public|protected)\s+\\$" | grep -oP '\$[^;]*')
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
        relations=$(awk '/class/,/function\s+\w+\(/' $1/$i |  awk "/$relationType/,/\)/" | awk '/targetEntity="/,/"/' | grep -oP 'targetEntity="[^"]+"')
        if [ -n "$relations" ]
        then
            for relation in $relations
            do
                relatedEntity=${relation/targetEntity=/}
                # Still have to eliminate namespace in order to match class name with file names ($i)
                relatedEntity=$(echo $relatedEntity | grep -Po '\w+(?=\")')
                if [ "$relationType" == "ManyToOne" ] 
                then
                    arrow=' "n" --o "1" '
                elif [ "$relationType" == "OneToOne" ]
                then
                    arrow=' "1" --o "1" '
                elif [ "$relationType" == "ManyToMany" ]
                then
                    arrow=' "n" --o "n" '
                fi
                echo ${i/.php/} $arrow $relatedEntity >> $outFile
            done

        fi
    done
done

echo "@enduml" >> $outFile
cat $outFile 
