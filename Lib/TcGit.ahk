#Include %A_LineFile%\..\Includes.ahk

/** Class TcGit
*/
Class TcGit extends Accessors
{
	_path	:= ""
	_Ini 	:= new Ini( A_LineFile "\..\TcGit.ini" )	
	_Repository 	:= new Repository().Parent(this)	
	_Directory 	:= new Directory().Parent(this)
	_ReadMe 	:= new ReadMe().Parent(this)
	_MsgBox 	:= new MsgBox()

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
		this.Directory().setName()
		this.Repository().setUrl()		
				
		;MsgBox,262144,, TcGit, 2
		;MsgBox,262144,variable, % this._ini,3 
	}
	/**
	 */
	_setUsername()
	{
		this._username := this._Ini.get( "config", "username" )
	} 
	/**
	 */
	cmd( $cmd, $params:="" )
	{
		
		if( this._commands.hasKey($cmd) )
			this._run[$cmd] := $params
		return this
	}
	/** 
	 */
	init( $repository_url:="" )
	{
		;if( $repository_url != "" )
			;this.Repository().setUrl( $repository_url:="" )

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
		;Dump(this._joinCommands(), "this._joinCommands()", 1)
		return % this._runCmd( this._joinCommands() )
	}
	/** 
	 */
	_joinCommands()
	{
		For $cmd, $params in this._run
			$run_cmd	.= " &&git " $cmd " " $params
		return %$run_cmd% 
	}
	/** run commands
		@param string $commands
	 */
	_runCmd( $commands )
	{
		$commands := RegExReplace( $commands, "^\s*&&", "" ) 
		return % ComObjCreate("WScript.Shell").Exec("cmd.exe /q /c cd " this._path " &&" $commands ).StdOut.ReadAll()
	}

	
	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this 
	}
	
	
	
}