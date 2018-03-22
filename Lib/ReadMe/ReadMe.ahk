﻿/** Class ReadMe
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
		Run, %COMMANDER_PATH%\TOTALCMD64.EXE /O /S /L=%$dir%
	} 

	
}