/** Class Install
*/
Class Install
{
	_TcCommand 	:= new TcCommand()
	_MsgBox 	:= new MsgBox()		
	_launcher_path	:= ""
	_cmd_prefix	:= "TcGit-"
	
	__New()
	{
		this._launcher_path	:= this._combinePath( A_LineFile, "\..\..\..\TcGitLauncher.ahk" )
		;Dump(this._launcher_path, "this._launcher_path", 1)
		this._TcCommand.cmd(this._launcher_path)
	}
	/**
	 */
	install()
	{
		;MsgBox,262144,, Test,2
		if( this._MsgBox.confirm( "Install commands for TcGit ?" ) )
			this._commands()
		
		return this
	}
	/**
	 */
	_commands()
	{
		this._cmdInitFolder()
	}
	/**
	 */
	_cmdInitFolder()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "ini-folder")
			.menu("Init current folder")
			.tooltip("TcGit - Init current folder")			
			.param("%P", "init-folder") ;"
			.create()
	} 
	

	/** Combine absolute and relative paths
	*/
   _combinePath( $absolute, $relative)
   {
	   $absolute := RegExReplace( $absolute, "\\$", "" ) ;;; remove last  slash\
	   $relative := RegExReplace( RegExReplace( $relative, "^\\", "" ), "/", "\" ) ;" ; remove first \slash, flip slashes
	   $relative := RegExReplace( $relative, "/", "\" ) ;" ;  flip slashes							  
										  
	   VarSetCapacity($dest, (A_IsUnicode ? 2 : 1) * 260, 1) ; MAX_PATH
	   DllCall("Shlwapi.dll\PathCombine", "UInt", &$dest, "UInt", &$absolute, "UInt", &$relative)
	   return RegExReplace( $dest, "\\+", "\" ) ; "
   }
	   
	
}
 