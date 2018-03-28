/** Local Directory of git hub repository
*/
Class Directory extends Parent
{
	;_path	:= A_WorkingDir
	;_current	:= A_WorkingDir
	;_repository	:=
	_name	:= "" ; name of dir
	
	_paths	:=	{"root":	A_WorkingDir
			,"current":	A_WorkingDir}
			
			
	setRoot($repo_state:="initialized")
	{
		if( $repo_state=="initialized" && ! this.hasGitFolder(this.path("current")))
			this._searchRoot()

		
		this.name(this._paths.root)
	}
	/** search for in tree for .git folder
	 */
	_searchRoot()
	{
		$path := this.path("current")
		
		While $path != $drive
		{
			if( this.hasGitFolder($path) ){
				this._paths.root	:= $path
				break
			}
			SplitPath, $path,, $path,,, $drive
		}
		if( $path == $drive )
			this.MsgBox().exit( "LOCAL REPOSITORY DOES NOT EXISTS.`n`n In path:`n" this.path("current") "`n`n", 10)
	}

	/** get path to root or current folder
	  *
	  */
	path( $path:="root" )
	{
		return $path=="root" ? this._paths.root : this._paths.current
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
	hasGitFolder($dir)
	{
		return % InStr(FileExist($dir "\.git"), "D") != 0		
	}	

	
	
}

