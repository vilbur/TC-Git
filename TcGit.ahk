#SingleInstance force

#Include %A_LineFile%\..\Lib\TcGit.ahk

$command	= %1%
$parameter	= %2% 
StringLower, $command, $command


if( ! new Ini().exists() )
	new Install().install()

$TcGit := new TcGit($command)

if( $command == "install" )
	new Install().install()

else if( $command == "init" )
	new TcGit("init").init()
	
else if( $command == "create-dir" )
	$TcGit.Directory().cloneOrCreate()
	
else if( $command == "create-readme" )
	$TcGit.ReadMe().create( GetKeyState("Ctrl", "P") ? $parameter : "" )

		
else
{

	if( $command == "create-ignore" )
		$TcGit.GitIgnore().create()
		
	else if( $command == "command-line" ){
		$cmd := "cmd.exe /K cd " $TcGit.Directory().path()
		Run *RunAs %$cmd%
		
	}else if( $command == "browser" )
		$TcGit.openBrowser()
	
}

