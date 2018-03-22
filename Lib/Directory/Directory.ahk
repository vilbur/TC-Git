/** Class Directory
*/
Class Directory extends Parent
{
	_path	:= A_WorkingDir 
	_name	:= "" ; name of dir
	
	__New()
	{
		this.name(this._path)
	}
	/**
	 */
	path( $path:="" )
	{
		if($path) {
			this._path := RegExReplace( RegExReplace( $path, "[\\\/]+$", "" ), "/", "\" ) ; "
			this.name(this._path)			
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
	/** create new dir with readme.me and ignore file
	  
	 */
	create()
	{
		$dir_name := this.MsgBox().input( "CREATE DIR", "New directory name" )
		if( ! $dir_name )
			ExitApp
		
		this.path( this.path() "\\" $dir_name ) 	
		
		FileCreateDir, % this.path()

		this.ReadMe().create()
		this.GitIgnore().create()
	}
	/**
	 */
	hasGitFolder()
	{
		return % InStr( (FileExist this.name() "\.git") , "X" ) != 0
	}	

	
	
}

