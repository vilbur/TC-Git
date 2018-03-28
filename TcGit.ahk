#SingleInstance force

#Include %A_LineFile%\..\Lib\TcGit.ahk

$command	= %1%
$parameter	= %2% 
StringLower, $command, $command


if( ! new Ini().exists() )
	new Install().install()


if( $command == "install" )
	new Install().install()

else if( $command == "init" )
	new TcGit("newRoot").init()
	
else
{
	$TcGit 	:= new TcGit()
		
	if( $command == "create-dir" )
		$TcGit.Directory().create()
	
	else if( $command == "readme" )
		$TcGit.ReadMe().create( GetKeyState("Ctrl", "P") ? $parameter : "" )
		
	else if( $command == "command-line" ){
		$cmd := "cmd.exe /K cd " $TcGit.Directory().path()
		Run *RunAs %$cmd%
		
	}else if( $command == "browser" )
		$TcGit.openBrowser()
	
}

