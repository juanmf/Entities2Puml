# Entities2Puml
This script aims to generate a puml file describing your Doctrine data model.
Then you just parse the dorectory where the output file is with plantuml.jar and it renders de Class Model for you.

Get PlantUml
============
To download planuml visit http://plantuml.com/ and follow instructions.

Run script
==========
Go to a terminal
```
prompt $ Entities2Puml.sh /path/to/BundleWithEntitiesDirectory/Entity outFile.puml
```

Process script Output
=====================
You will need a JRE 
```
prompt $ java -jar /<path-to-downloaded plantuml jar>/plantuml.jar
```
Then, if missing, add puml in the File extensions textbox. Select your target directory with Change Directory button and plantuml will find all puml files in it and will generaete the file.png versions.
