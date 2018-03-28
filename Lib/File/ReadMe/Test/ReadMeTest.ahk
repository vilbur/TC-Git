#SingleInstance force

#Include %A_LineFile%\..\..\..\TcGit.ahk


$TcGit 	:= new TcGit()


/*  In current dir create
		1) readme.md file 
		2) redme-suffix.md 
*/
$TcGit.ReadMe().create()
	.create("-suffix")