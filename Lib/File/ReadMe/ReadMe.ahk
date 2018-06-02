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
		
		if( $suffix && FileExist($dir "\readme.md") )
			FileCopy, % $dir "\readme.md", % $dir "\\" $filename, 1
		
		else
			this._createNewReadme($dir, $filename)
	}
	/**
	 */
	_createNewReadme($dir, $filename)
	{
		SplitPath, $dir, $dir_name

		$content	:= "# " $dir_name

		this.createFile( $dir, $filename, $content )	
	}



}