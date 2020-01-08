# LoggingApp

##Instructions
When installing the application for the first time on your simulator you'll have to do the following things manually. First of all it should print a link to database, this can be seen in the debug window of XCode and should look something like: 


This is the location of the local database of the simulator. Copy everything except "file://".	
Open the terminal and type "open /Users/geartotten/Library/Developer/CoreSimulator/Devices/6E509F73-6C1E-4B66-9E5C-2F4FDD3DAA29/data/Containers/Shared/AppGroup/B39F3427-81A5-4FA7-BCE3-F637920BFBA7/". In this you will see a loggingsapp.sqlite file, personally I use TablePlus to open it. Open the ZAIRCRAFT table and add some aircrafts manually. Fill in the ZSERIALNUMBER and ZTYPE fields and save it. When you build the App again it will now show the aircrafts you have created.

###Warnings
When the database models have been changed you will need to delete the database file named above. When you build it again you will have to add the aircrafts again.