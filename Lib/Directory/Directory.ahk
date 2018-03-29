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
			
			
	setRoot($repo_state)
	{
		if( ! $repo_state=="init" && ! this.hasGitFolder(this.path("current")))
			this._searchGitFolder()
		
		this.name(this._paths.root)
	}
	/** search for in tree for .git folder
	 */
	_searchGitFolder()
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
	cloneOrCreate()
	{
		$dir_name_or_url := this.MsgBox().input( "CREATE OR CLONE REPOSITORY ", "Enter directory name to create new or url for clone" )
		
		if( this.Repository().exists( $dir_name_or_url ) )
			this.Repository().setUrl( $dir_name_or_url )
			
		$dir_name := this.MsgBox().input( "CREATE OR CLONE REPOSITORY ", "Enter directory name", {"default": this.Repository().name()} )
			
		if( ! $dir_name )
			ExitApp
		
		this._paths.root	:= this.path() "\\" $dir_name
		this._paths.current	:= this._paths.root
		
		FileCreateDir, % this.path()
		
		if( this.Repository()._url )
			this.Parent().init().cmd("pull").run()
		
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











