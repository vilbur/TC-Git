/** Class File
*/
Class File extends Parent
{
	/**
	 */
	createFile( $dir, $filename, $content )
	{
		$file_path	= %$dir%\%$filename%
		$message	:= FileExist( $file_path ) ? "          FILE """ $filename """ EXISTS:`n`n`t    OVERRITDE ?" : "             CREATE " $filename """ ?"
		$answer	:= this.MsgBox().confirm("Create " $filename, $message)

		if( ! $answer )
			return
			
		FileDelete, %$file_path%
		FileAppend, %$content%, %$file_path%
		this._updateTotalCommander($dir)
		return this
	}

	/**
	 */
	_updateTotalCommander($dir)
	{
		WinGet, $process_name , ProcessName, ahk_class TTOTAL_CMD
		Run, %COMMANDER_PATH%\%$process_name% /O /S /L=%$dir%
	}


}