/** Class TCcommand
*/
Class TCcommand
{
	_commander_path	:= ""	
	_usercmd_ini	:= "" ; save commands
	_name	:= ""
	_cmd	:= ""	
	_param	:= ""
	_button	:= ""
	_icon	:= ""			
	
	/** _setTabsPath
	 */
	__New()
	{
		$commander_path	= %Commander_Path%	
		$_usercmd_ini	= %Commander_Path%\usercmd.ini		
		this._commander_path	:= $commander_path		
		this._usercmd_ini	:= $_usercmd_ini		
	}
	/**
	 */
	name( $name )
	{
		this._name 	:= $name
		this._shortcut	:= new TcShortcut().name($name)
		return this 		
	}
	/**
	 */
	cmd( $cmd )
	{
		this._cmd := """" this._replaceCommanderPathEnvVariable($cmd) """"
		
		return this 		
	}
	/**
	 */
	param( $params:="" )
	{
		this._param := $params
		return this 		
	}
	/**
	 */
	tooltip( $tooltip )
	{
		this._button := $tooltip
		return this 		
	}
	/**
	 */
	icon( $icon )
	{
		this._icon := $icon
		return this 		
	}
	
	/**
	 */
	create()
	{
		this._writeToIni( "cmd" )
		this._writeToIni( "param" )
		this._writeToIni( "button" )
		this._writeToIni( "icon" )
		
		return this
	}
	/**
	 */
	delete( )
	{
		if( this._name )
			IniDelete, % this._usercmd_ini, % this._name
	}
	/**
	 */
	shortcut( $keys* )
	{
		if( $keys )
			return % this._shortcut.keys($keys)
		
		return this._shortcut
	}
	/**
	 */
	_writeToIni( $key )
	{
		;Dump($key, "_writeToIni", 1)
		if( this["_" $key ] != "" )
			IniWrite, % this["_" $key ],	% this._usercmd_ini, % this._name, %$key%		
	} 
	/** Replace path to %COMMANDER_PATH% back
			E.G.: "C:\TotalCommander" >>> "%COMMANDER_PATH%"
	 */
	_replaceCommanderPathEnvVariable( $cmd )
	{
		$commander_path_rx := RegExReplace( this._commander_path, "i)[\\\/]+", "\\" )
		return % RegExReplace( $cmd, "i)" $commander_path_rx, "%COMMANDER_PATH%" ) 
	}
	
}

