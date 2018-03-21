#Include %A_LineFile%\..\Includes.ahk

/** Class TcGit
*/
Class TcGit extends Accessors
{
	_path	:= ""
	_Repository 	:= new Repository().Parent(this)	
	_Directory 	:= new Directory()
	_ReadMe 	:= new ReadMe().Parent(this)
	_MsgBox 	:= new MsgBox()
	_ini	:= A_LineFile "\..\TcGit.ini"

	_username	:= ""	
	
	_commands :=	{"init":	"init"
		,"ignorecase":	"config core.ignorecase false"
		,"add-all":	"add ."
		,"push":	"origin master"		
		,"pull":	"origin master"
		,"fetch":	"fetch --all"
		,"commit":	""
		,"reset":	"--hard origin/master"
		,"remote-add":	"remote add origin"
		,"remote-set":	"set-url origin"		
		,"git":	""
		,"":	""}
	
	_run	:= [] ; commands to run

	__New( $path ){
		this._path	:= $path
		this._setUsername()
		this._Repository.setName().setUrl()
				
		;MsgBox,262144,, TcGit, 2
		;MsgBox,262144,variable, % this._ini,3 
	}
	/**
	 */
	_setUsername()
	{
		this._username := this._getIniValue( "username" )
	} 
	/**
	 */
	cmd( $cmd, $params:="" )
	{
		this._run[$cmd] := $params
		return this
	}
	/**
	 */
	create()
	{
		
	}
	/**
	 */
	run()
	{
		;this._Repository.exists()
		;Dump(this._Repository.exists(), "this._Repository.exists()", 1)
		Dump(this._joinCommands(), "this._joinCommands()", 1)

		;$cmd	:= "cd " this._path " " this._joinCommands()
		;$cmd	:= $cd_path " &&git " this._commands[$commands]
			
	
	}
	
	
	/** 
	 */
	_joinCommands()
	{
		For $cmd, $params in this._run
			$run_cmd	.= " &&git " $cmd " " $params
		return %$run_cmd% 
	} 
	/** set ini value
	 */
	_setIniValue( $key, $value )
	{
		IniWrite, %$value%, % this._ini, config, %$key%
	}
	
	/** set ini value
	 */
	_getIniValue( $key )
	{
		IniRead, $value, % this._ini, config, %$key%		
		return % $value != "ERROR" ? $value : "X"
	}
	
	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this 
	}
	
	
	
}