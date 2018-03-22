/** Class Install
*/
Class Install
{
	_Ini 	:= new Ini( )		
	_TcCommand 	:= new TcCommand()
	_MsgBox 	:= new MsgBox()		
	_launcher_path	:= ""
	_cmd_prefix	:= "TcGit-"
	
	__New()
	{
		this._launcher_path	:= A_ScriptFullPath 
		this._TcCommand.cmd( this._launcher_path )
	}
	/**
	 */
	install()
	{
		if( this._MsgBox.confirm( "Install commands for TcGit ?" ) )
			this._commands()
		
		this._setIniDefaults()			
		
		return this
	}
	/**
	 */
	_setIniDefaults()
	{
		this._Ini.set( "config", "username", A_UserName )
		this._Ini.set( "prefixes" )
	}
	
	/**
	 */
	_commands()
	{
		this._cmdInitFolder()
		this._cmdReadme()		
	}
	/**
	 */
	_cmdInitFolder()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "ini-folder")
			.param("init")
			.menu("Init current folder")
			.tooltip("TcGit - Init current folder")			
			.create()
	} 
	/**
	 */
	_cmdReadme()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "create-readme")
			.param("readme", "-source")
			.menu("Crate readme	( Ctrl to suffix ""-source"" )")
			.tooltip("TcGit - Crate readme in current folder")
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
 