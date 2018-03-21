#SingleInstance force

#Include %A_LineFile%\..\..\TcGit.ahk

$path	= %A_LineFile%\..\
$TcGit 	:= new TcGit( $path )


/*  In current dir create
		1) readme.md file 
		2) redme-suffix.md 
*/
$TcGit.ReadMe().create()
	.create("-suffix")