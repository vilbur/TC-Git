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
	new TcGit("init").init()
	
else if( $command == "create-dir" ){
		$TcGit 	:= new TcGit("cloneOrCreate")
	$TcGit.Directory().cloneOrCreate()

	
}
	;new TcGit("create-dir").Directory().create()	
		
else
{
	$TcGit 	:= new TcGit()
		
	if( $command == "create-readme" )
		$TcGit.ReadMe().create( GetKeyState("Ctrl", "P") ? $parameter : "" )
		
	if( $command == "create-ignore" )
		$TcGit.GitIgnore().create()
		
			
	else if( $command == "command-line" ){
		$cmd := "cmd.exe /K cd " $TcGit.Directory().path()
		Run *RunAs %$cmd%
		
	}else if( $command == "browser" )
		$TcGit.openBrowser()
	
}

