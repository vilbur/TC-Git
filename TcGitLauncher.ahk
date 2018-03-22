#SingleInstance force

#Include %A_LineFile%\..\Lib\TcGit.ahk

$path	= %1%
$command	= %2%

StringLower, $command, $command

$TcGit 	:= new TcGit( $path )

;$Install 	:= new Install().install()


;.cmd("init").cmd("ignorecase").run()

if( $command == "init-folder" )
	$TcGit.init()

