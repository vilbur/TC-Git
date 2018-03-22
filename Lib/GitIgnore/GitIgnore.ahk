/** Class GitIgnore
*/
Class GitIgnore extends Parent
{
	/**
	 */
	create( $force:=false )
	{
		$filename	= .gitignore
		$dir	:= this.Directory().path()
		$file_path	= %$dir%\%$filename%
		$message	:= FileExist( $file_path ) ? "FILE EXISTS:`n`n" $filename "`n`n OVERRITDE ?" : "CREATE ?`n`n" $filename
		
		if( $force==false )
			$answer := this.MsgBox().confirm("Create readmme.md", $message)
		
		if( $force==false && ! $answer )
			return

		FileDelete, %$file_path% 
		FileAppend, % (this._join( this.INI().getKeys("gitignore-defaults") ) ) , %$file_path%
		this._updateTotalCommander($dir)
		return this
	}
	
	/**
	 */
	_updateTotalCommander($dir)
	{
		Run, %COMMANDER_PATH%\TOTALCMD64.EXE /O /S /L=%$dir%
	}
	
	_join($array, $delimiter := "`n")
	{
		For $i, $value in $array
			$string .= ( $i>1 ? $delimiter : "" ) $value
		return %$string% 
	}

	
}