#SingleInstance force

#Include %A_LineFile%\..\MsgBox.ahk


$MsgBox 	:= new MsgBox()

;$MsgBox
;	.message("No title message")
;	.message("Title", "Message with title")
;	.message("Title", "Message with timeout", 2)
;	
;$MsgBox.confirm("Title", "confirm with yes")
;$MsgBox.confirm("Title", "confirm with no", "no")

;$MsgBox.input("Title", "Input prompt" )
;$MsgBox.input("Title", "Input prompt",  { "x":"", "y":"", "w":"", "h":128, "default":"Default text" }	 )

$MsgBox.exit("Exiting script", "Message then ExitApp" )
