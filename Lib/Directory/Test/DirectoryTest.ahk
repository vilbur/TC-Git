#SingleInstance force

#Include %A_LineFile%\..\..\..\TcGit.ahk

$TcGit 	:= new TcGit()


$TcGit.Directory().findGitFolder()
