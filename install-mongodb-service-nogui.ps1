#Path of folder we are creating
$MongoPath = "C:\Mongo"
#Path of config file we are creating
$MongoConfig = "$MongoPath\mongod.cfg"

#Test if MongoDB is already installed
if (Test-Path -path "C:\Program Files\MongoDB") {
      Write-Output "MongoDB is already installed`n"
} else {
      Write-Output "Could not find any Mongo packages, beginning install...`n"
}

#Make log, data, and data/db directories to the C:\Mongo folder
md "$MongoPath\log"
md "$MongoPath\data\db"

#Create mongod.log file
"" > C:\Mongo\log\mongod.log

#Populate config file we created with bare-minimum input
@"
systemLog:
    destination: file
    path: C:\Mongo\log\mongod.log
storage:
    dbPath: C:\Mongo\data\db
"@	> "$MongoConfig"

#Download the MSI file and output it as mongodb.msi
Write-Output "Directories and config created, downloading...`n"
Invoke-WebRequest https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-6.0.3-signed.msi -OutFile mongodb.msi 
 
#Install MongoDB and wait for it to finish before proceeding
#Output logs from install to mdbinstall.log 
#Add ServerService variable to install as service
#Should install Compass set to FALSE
Write-Output "Download finished, now installing MongoDB`n..."
Start-Process msiexec.exe -Wait -ArgumentList '/l*v mdbinstall.log /qn /i mongodb.msi ADDLOCAL="ServerService" SHOULD_INSTALL_COMPASS="0"'

#Starts the MongoDB service
Write-Output "Starting service`n"
Start-Service MongoDB
