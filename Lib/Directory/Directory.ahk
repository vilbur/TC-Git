/** Class Directory
*/
Class Directory extends Parent
{
	_path	:= A_WorkingDir 
	_name	:= "" ; name of dir
	
	__New( )
	{
		this.name(this._path)
		;this._path	:= A_ScriptDir
		
		;MsgBox,262144,, TcGit, 2
		;MsgBox,262144,variable, % this._ini,3 
	}
	/**
	 */
	path()
	{
		;if($path) {
		;	this._path := RegExReplace( RegExReplace( $path, "[\\\/]+$", "" ), "/", "\" ) ; "
		;	this.name(this._path)			
		;}
		
		;return $path ? this : this._path
		return this._path		
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

