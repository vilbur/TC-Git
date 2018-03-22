#SingleInstance force

#Include %A_LineFile%\..\Lib\TcGit.ahk

$command	= %1%
$parameter	= %2% 
StringLower, $command, $command


if( ! new Ini().exists() )
	new Install().install()

;Dump( new Ini().file() , "", 1)

;.cmd("init").cmd("ignorecase").run()

if( $command == "install" )
	new Install().install()

else {
	
	$TcGit 	:= new TcGit()

	if( $command == "init" )
		$TcGit.init()
		
	else if( $command == "readme" )
		$TcGit.ReadMe().create( GetKeyState("Ctrl", "P") ? $parameter : "" )
	

	
}

