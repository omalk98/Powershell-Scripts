#Requires -RunAsAdministrator
# System Database service stopper
# Written by Omar Hussein
#
# Works for PostgreSQL, MongoDB and MSSQL
# This script takes the first argument as command (start or stop), 
# And a second argument to specify which service to apply the command to

if ($Args[0] -eq '-h' -or $Args[0] -eq '-help') {
    Write-Host '    serciveCPUBoost script. Stops or Starts database services based on need.
    {Requires Admin Privileges}
    
        [options]
        -h, -help       Display help menu

        [Service Names]
        pg      --> PostgreSQL
        mongo   --> MongoDB
        mssql   --> MicrosoftSQL

        Takes Command [start/stop] [-a]			{Apply to all Databases}
                                   [service_name]	{Apply to specific Database}'
    exit
}
elseif($Args[0] -ne 'start' -and $Args[0] -ne 'stop') {
    Write-Host -ForegroundColor 'red' 'Error: Not a valid command, use "start" or "stop" [service_name]'
    exit
}

if ($Args[0] -eq 'stop') {
    if ($Args[1] -eq '-a' -or $Args[1] -eq '-all') {
        Stop-Service 'postgresql-x64-14', 'MSSQL$SQLEXPRESS', 'SQLWriter', 'MongoDB'
        Write-Host -ForegroundColor 'yellow' 'All DB serivces stopped successfully'
    }
    elseif($Args[1] -eq 'pg'){
        Stop-Service 'postgresql-x64-14'
        Write-Host -ForegroundColor 'yellow' 'PostgreSQL DB serivce stopped successfully'
    }
    elseif($Args[1] -eq 'mssql'){
        Stop-Service 'MSSQL$SQLEXPRESS', 'SQLWriter'
        Write-Host -ForegroundColor 'yellow' 'MicrosoftSQL DB serivce stopped successfully'
    }
    elseif($Args[1] -eq 'mongo'){
        Stop-Service 'MongoDB'
        Write-Host -ForegroundColor 'yellow' 'Mongo DB serivce stopped successfully'
    }
    else {
        Write-Host -ForegroundColor 'red' 'Invalid service name.'
        exit
    }
}
elseif ($Args[0] -eq 'start') {
    if ($Args[1] -eq '-a' -or $Args[1] -eq '-all') {
        Start-Service 'postgresql-x64-14', 'MSSQL$SQLEXPRESS', 'SQLWriter', 'MongoDB'
        Write-Host -ForegroundColor 'green' 'All DB serivces started successfully'
    }
    elseif($Args[1] -eq 'pg'){
        Start-Service 'postgresql-x64-14'
        Write-Host -ForegroundColor 'green' 'PostgreSQL DB serivce started successfully'
    }
    elseif($Args[1] -eq 'mssql'){
        Start-Service 'MSSQL$SQLEXPRESS', 'SQLWriter'
        Write-Host -ForegroundColor 'green' 'MicrosoftSQL DB serivce started successfully'
    }
    elseif($Args[1] -eq 'mongo'){
        Start-Service 'MongoDB'
        Write-Host -ForegroundColor 'green' 'Mongo DB serivce started successfully'
    }
    else {
        Write-Host -ForegroundColor 'red' 'Invalid service name.'
        exit
    }
}