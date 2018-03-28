/** Class Install
*/
Class Install
{
	_Ini 	:= new Ini( )		
	_TcCommand 	:= new TcCommand()
	_MsgBox 	:= new MsgBox()		
	_launcher_path	:= ""

		;;;COMMAND	       MENU	       TOOLTIP	       ICON	PARAMETERS
	_commands :=	{"install":	[ "Install",	"Install",	"",	""	]
		,"init":	[ "Init current folder",	"Init current folder",	A_ScriptDir "\icons\init.ico",	""	]
		,"create-dir":	[ "Crate directory",	"Crate directory in current folder",	A_ScriptDir "\icons\create.ico",	""	]
		,"create-readme":	[ "Crate directory",	"Crate readme.md",	A_ScriptDir "\icons\readme.ico",	"-source"	]
		,"browser":	[ "Open on GitHub",	"Open on GitHub ( Ctrl open in root)",	A_ScriptDir "\icons\browser.ico",	""	]					
		,"command-line":	[ "Open command line",	"Open command line in repository",	A_ScriptDir "\icons\command-line.ico",	""	]}

	__New()
	{
		this._launcher_path	:= A_ScriptFullPath 
		this._TcCommand.cmd( this._launcher_path )
	}
	/**
	 */
	install()
	{
		MsgBox, 4, , Ddo You want install TC-Git ?
		IfMsgBox, No
			return 
		
		if( this._MsgBox.confirm( "Install commands for TC-Git ?" ) )
			this.createCommands()
		
		this._setIniDefaults()			
		
		return this
	}
	/**
	 */
	_setIniDefaults()
	{
		this._Ini.set( "config", "username", A_UserName )
		this._Ini.set( "prefixes" )
		this._Ini.set( "gitignore-defaults",	"*.bak" )
		this._Ini.set( "gitignore-defaults",	".komodotools" )
		this._Ini.set( "command-line",	"path",	"cmd.exe" )						
	}

	/**
	 */
	createCommands()
	{
		For $command, $values in this._commands
			this._TcCommand.clone()
				.name( "TC-Git-" $command)
				.param($command, $values[4])
				.menu( "TC-Git - " $values[1])
				.tooltip("TC-Git - " $values[2])
				.icon($values[3])			
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
 