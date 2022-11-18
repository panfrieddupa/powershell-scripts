#Function to get version of Node
Function Get-NodeInstall {
    [CmdletBinding()]
    $NodeInfo = node -v
    $NodeInfo
}
#Test if Node is already installed
if (Get-NodeInstall) {
      Write-Output "Node is already installed`n"
} else {
      Write-Output "Could not find any Node packages, beginning install...`n"
}

#Download the MSI file and output it as nodeInstall.msi
Write-Output "Downloading...`n"
Invoke-WebRequest https://nodejs.org/dist/v18.12.1/node-v18.12.1-x64.msi -OutFile nodeInstall.msi 
 
#Install Node and wait for it to finish before proceeding
#Output logs from install to node.log 
Write-Output "Download finished, now installing Node`n..."
Start-Process msiexec.exe -Wait -ArgumentList '/l*v node.log /qn /i nodeInstall.msi'

#Note: You don't need to restart computer to ensure node is installed, but do need a new terminal window
