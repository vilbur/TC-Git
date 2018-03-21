#SingleInstance force

#Include %A_LineFile%\..\Lib\TcGit.ahk

$path	= %1%
$command	= %2%
StringLower, $command, %1%

$TcGit 	:= new TcGit( $path )


;.cmd("init").cmd("ignorecase").run()
