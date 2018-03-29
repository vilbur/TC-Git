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
		;Dump($dir, "dir", 1)
		$content	:= "# " $dir_name

		this.createFile( $dir, $filename, $content )
	}


}