# Entities2Puml
This script aims to generate a puml file describing your Doctrine data model.
Then you just parse the dorectory where the output file is with plantuml.jar and 
it renders de Class Model for you.

Get PlantUml
============
To download planuml visit http://plantuml.com/download.html and follow download link.

Run script
==========
Go to a terminal
```
prompt $ Entities2Puml.sh /path/to/BundleWithEntitiesDirectory/Entity [outFile.puml]
```
Or if you want to parse all Entities in the project
```
prompt $ Entities2Puml.sh /path/to/ProjectRootDirectory/ [outFile.puml]
```
outFile.puml is optional, if you don't pass it the file tempUml.puml is generated and 
(with or without 2nd argimen) it's printed on screen.

Process script Output
=====================
You will need a JRE 
```
prompt $ java -jar /<path-to-downloaded plantuml jar>/plantuml.jar
```
Then, if missing, add puml in the File extensions textbox. Select your target directory with 
Change Directory button and plantuml will find all puml files in it and will generaete the 
file.png versions that you can open with any image viewer.
