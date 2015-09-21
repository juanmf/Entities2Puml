# Entities2Puml
This scripts aim to generate a puml file describing your Doctrine data model 
or your MySQL database.
Then you just parse the directory where the output file is with plantuml.jar and 
it renders the Class Model for you.

Get PlantUml
============
To download plantuml visit http://plantuml.com/download.html and follow download link.

Run script
==========
**For Doctrine**
Go to a terminal
```
prompt $ Entity2Puml.sh /path/to/BundleWithEntitiesDirectory/Entity [outFile.puml]
```
Or if you want to parse all Entities in the project
```
prompt $ Entity2Puml.sh /path/to/ProjectRootDirectory/ [outFile.puml]
```
outFile.puml is optional, if you don't pass it the file tempUml.puml is generated and 
(with or without 2nd argimen) it's printed on screen.

**For MySQL**
1st make sure your config_mysql.sh has the right values for user, host and so on. 
Go to a terminal.
```
prompt $ MySqlSchema2Puml.sh <dataBase Name> [outFile.puml]
```
Or if you want to parse all Entities in the project
```
prompt $ MySqlSchema2Puml.sh <dataBase Name> [outFile.puml]
```
outFile.puml is optional, if you don't pass it the file tempUml.puml is generated and 
(with or without 2nd argimen) it's printed on screen.

Process script Output
=====================
You will need a JRE, you can donwload it at https://java.com/en/download/
```
prompt $ java -jar /<path-to-downloaded plantuml jar>/plantuml.jar
```
Then, if missing, add puml in the File extensions textbox. Select your target directory with 
Change Directory button and plantuml will find all puml files in it and will generaete the 
file.png versions that you can open with any image viewer.
