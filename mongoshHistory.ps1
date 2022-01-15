# mongosh.exe & mongo.exe command history lookup tool
# Written by Omar Hussein

# This script will take a single Argument as a positive integer 
# That number will be used display the last N lines (commands) you input in mongosh.exe
# If no Argument supplied script will display last 50 lines (commands)

if ($Args[0] -eq "-o" -or $Args[0] -eq "-old") {
		$Args[0] = $Args[1]
		$old = 1
}
if ($Args[2]) {
	$Args[1] = $Args[2]
}

if ($Args[0]) {	
	if ($Args[0] -match '-.*'){
		if ($Args[0] -eq "-h" -or $Args[0] -eq "-help") {
			Write-Host -foregroundcolor "green" "	mongoshHistory [Int+] 	Accepts positive integers only
			
			[options]
			-h, -help				Display help menu
			-a, -all, -full			Display entire command history
			-o, -old				Display mongo.exe command history
			
		#This script displays last N number of lines (commands) you input in mongosh.exe 
		 if argument supplied, otherwise will display last 50 lines (commands).
		 This script can also display mongo.exe history."
			exit
		}
		elseif ($Args[0] -eq "-all" -or $Args[0] -eq "-a" -or $Args[0] -eq "-full") {
			$valid = 1
		}
		elseif ($Args[0] -match '-\d\d*' -and [Int]$Args[0] -le 0) {
			 Write-Host -foregroundcolor "red" "Only posotive values accepted!" 
			 exit
		}
		else {
			Write-Host -foregroundcolor "red" "Incorrect option! use -help or -h to view options"
			exit
		}
	}
	elseif ($Args[0] -match '\d\d*') {
			$lines = $Args[0]
			$limit = 1
			$valid = 1
	}
	elseif ($Args[0] -match '..*') {
		$keyword = $Args[0]
		$limit = 1
		$valid = 1
		$search = 1
		$lines = 50
	}
	else {
		Write-Host -foregroundcolor "red" "Incorrect option! use -help or -h to view options"
		exit
	}
}
else {
	$lines = 50
	$limit = 1
	$valid = 1
}

if ($Args[1] -match '..*') {
		$keyword = $Args[1]
		$search = 1
}

if ($valid) {
	if ($old) {
		#Path for mongo.exe History Log
		$path="~\.dbshell"
	}
	else {
		#Path for mongosh.exe History Log
		$path="~\AppData\Roaming\mongodb\mongosh\mongosh_repl_history"
	}
	
	if (-not (Test-Path $path)){
		Write-Host -foregroundcolor "red" "Path ($path) needs modification!"
		exit
	}
	elseif ($limit){
		if ($search){
			Get-Content $path | select -First $lines | select-String $keyword
		}
		else {
			Get-Content $path | select -First $lines
		}
	}
	else {
		if ($search){
			Get-Content $path | select-String $keyword
		}
		else {
			Get-Content $path
		}
	}
	
	if ($old) {
		Write-Host -foregroundcolor "yellow" "Consider using mongosh.exe, mongo.exe is a deprecated version.
you can download mongosh.exe here: https://docs.mongodb.com/mongodb-shell/install/"
	}
}