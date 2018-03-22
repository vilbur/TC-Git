#SingleInstance
#Include %A_LineFile%\..\..\Lib\TcGit.ahk

$path	:= "c:\GoogleDrive\TotalComander\TC-tools\TC-tool-laravel"
;$path	:= "c:\GoogleDrive\TotalComander\TC-tools\laravel"
;$path	:= "c:\GoogleDrive\TotalComander\TC-tools\TC-Git"

$TcGit 	:= new TcGit( $path )

Dump($TcGit, "TcGit", 1)

;/** Init Repository
;  */
;$TcGit.init()
;	.cmd("init")
;	.cmd("ignorecase")
;	.run()



/** Init Repository
  */

;$getOrigin := $TcGit.getOrigin()
;Dump($getOrigin, "getOrigin", 1)


;$hasGitFolder := $TcGit.Directory().hasGitFolder()
;Dump($hasGitFolder, "hasGitFolder", 1)
