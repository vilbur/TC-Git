/** Class GitIgnore
*/
Class GitIgnore extends File
{
	
	/**
	 */
	create()
	{
		$filename	= .gitignore
		$dir	:= this.Directory().path()
		$content	:= this._join( this.INI().getKeys("gitignore-defaults") )


		this.createFile( $dir, $filename, $content )
	}
	/**
	 */
	_join($array, $delimiter := "`n")
	{
		For $i, $value in $array
			$string .= ( $i>1 ? $delimiter : "" ) $value
		return %$string% 
	}
	;/**
	; */
	;_updateTotalCommander($dir)
	;{
	;	Run, %COMMANDER_PATH%\TOTALCMD64.EXE /O /S /L=%$dir%
	;}
	
}