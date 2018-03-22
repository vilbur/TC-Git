#SingleInstance force

#Include %A_LineFile%\..\..\TcCommand.ahk
#Include %A_LineFile%\..\..\TcShortcut.ahk

/* Create command with shortcute
*/
$CommandCreate 	:= new TcCommand()

$CommandCreate
	.name("TcCommand-test")
	.cmd("c:\GoogleDrive\TotalComander\TcCommand-test")
	.param("""%P""")
	.tooltip("Test menu text")
	.icon("wcmicons.dll,43")
	.create()
	.shortcut( "ctr", "shift", "alt", "win", "f12" )
	.create("force")		

/* Delete command
  
*/
new TcCommand().name("TcCommand-test").delete()
	