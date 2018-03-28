/** Class ReadMe
*/
Class ReadMe extends File
{
	/**
	 */
	create( $suffix:="", $force:=false )
	{
		$filename	= readme%$suffix%.md
		$dir	:= this.Directory().path("current")
		SplitPath, $dir, $dir_name
		
		$content	:= "# " $dir_name

		this.createFile( $dir, $filename, $content )
	}

	;/**
	; */
	;_updateTotalCommander($dir)
	;{
	;	WinGet, $hwnd , ID, ahk_class TTOTAL_CMD
	;	WinGet, $process_name , ProcessName, %$hwnd%
	;
	;	Run, %COMMANDER_PATH%\%$process_name% /O /S /L=%$dir%
	;}


}