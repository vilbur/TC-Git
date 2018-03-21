/** Class Directory
*/
Class Directory extends Parent
{
	_name	:= "" ; name of repository
	/**
	 */
	setName()
	{
		SplitPath, % this.Parent()._path, $dir
		this._name	:= $dir
		return this
	}
	/**
	 */
	hasGitFolder()
	{
		return % InStr( (FileExist this.Parent()._path "\.git") , "X" ) != 0
	}	
	
	
}
