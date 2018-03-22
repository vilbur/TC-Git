/** Class Directory
*/
Class Directory extends Parent
{
	_path	:= "" ; path to current dir
	_name	:= "" ; name of dir
	
	__New( $path )
	{
		this._path	:= $path
		
		;MsgBox,262144,, TcGit, 2
		;MsgBox,262144,variable, % this._ini,3 
	}
	/**
	 */
	path( $path:="" )
	{
		if($path) {
			this._path := $path
			this.name($path)			
		}
		
		return $path ? this : this._path
	}
	/**
	 */
	name( $path:="" )
	{
		if( $path ){
			SplitPath, % $path, $dir
			this._name := $dir
		}
		
		return $name ? this : this._name
	} 

	/**
	 */
	hasGitFolder()
	{
		return % InStr( (FileExist this.name() "\.git") , "X" ) != 0
	}	

	
	
}
