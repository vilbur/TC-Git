/** Class ReadMe
*/
Class ReadMe extends Parent
{
	/**
	 */
	create( $suffix:="", $force:=false )
	{
		$filename	= readme%$suffix%.md
		$dir	:= this.Directory().path()
		$file_path	= %$dir%\%$filename%
		$message	:= FileExist( $file_path ) ? "FILE EXISTS:`n`n" $filename "`n`n OVERRITDE ?" : "CREATE ?`n`n" $filename

		if( $force==false )
			$answer := this.MsgBox().confirm("Create readmme.md", $message)

		if( $force==false && ! $answer )
			return

		FileDelete, %$file_path%
		FileAppend, % "# " this.Directory().name() , %$file_path%
		this._updateTotalCommander($dir)
		return this
	}

	/**
	 */
	_updateTotalCommander($dir)
	{
		WinGet, $hwnd , ID, ahk_class TTOTAL_CMD
		WinGet, $process_name , ProcessName, %$hwnd%

		Run, %COMMANDER_PATH%\%$process_name% /O /S /L=%$dir%
	}


}