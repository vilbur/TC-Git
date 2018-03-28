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
		;MsgBox,262144,, %A_ScriptDir% 
		MsgBox, 4, , Ddo You want install TC-Git ?
		IfMsgBox, No
			return 
		
		if( this._MsgBox.confirm( "Install commands for TC-Git ?" ) )
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
		this._Ini.set( "gitignore-defaults", "*.bak" )
		this._Ini.set( "gitignore-defaults", ".komodotools" )				
	}
	
	/**
	 */
	_commands()
	{
		this._cmdInstallFolder()
		this._cmdInitFolder()		
		this._cmdCreateDir()
		this._cmdReadme()				
	}
	/**
	 */
	_cmdInstallFolder()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "install")
			.param("install")
			.menu("Install TC-Git")
			.tooltip("TcGit - Install")			
			.create()
	}
	/**
	 */
	_cmdInitFolder()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "init")
			.param("init")
			.menu("Init current folder")
			.tooltip("TcGit - Init current folder")			
			.icon(A_ScriptDir "\icons\init.ico")			
			.create()
	}
	/**
	 */
	_cmdCreateDir()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "create-dir")
			.param("create-dir")
			.menu("Crate directory")
			.tooltip("TcGit - Crate directory in current folder")
			.icon(A_ScriptDir "\icons\create.ico")			
			.create()
	} 

	/**
	 */
	_cmdReadme()
	{
		this._TcCommand.clone()
			.name( this._cmd_prefix "create-readme")
			.param("readme", "-source")
			.menu("Crate readme.md	( Ctrl to suffix ""-source"" )")
			.tooltip("TcGit - Crate readme.md in current folder")
			.icon(A_ScriptDir "\icons\readme.ico")			
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
 