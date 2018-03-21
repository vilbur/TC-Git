#SingleInstance
#Include %A_LineFile%\..\..\Lib\TcGit.ahk

$path	:= "c:\GoogleDrive\TotalComander\TC-tools\TC-tool-laravel"

$TcGit 	:= new TcGit( $path )

/** Init Repository
  */
$TcGit 
	.cmd("init")
	.cmd("ignorecase")
	.run()