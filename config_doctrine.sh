#!/bin/bash
##
# configs
##
##
# Whether or not to include Class' attributes in diagram
##
includeAttrs=false

##
# The regex that is used by `grep -P` to identify Entity classes
##
entityAnnotation='\@[^\(]+(Entity|MappedSuperclass)'

##
# Filename pattern to include in search its used by `grep --include=PATTERN`.
##
scannedFilesPattern="*.php"

##
# Filename extension to strip from filename, used for classname assumption.
##
scannedFilesExtension=".php"

##
# end config
##
