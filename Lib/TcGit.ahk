#Include %A_LineFile%\..\Includes.ahk

/** Class TcGit
*/
Class TcGit extends Accessors
{
	_Ini 	:= new Ini( A_LineFile "\..\TcGit.ini" )	
	_Repository 	:= new Repository().Parent(this)	
	_Directory 	:= new Directory().Parent(this)
	_ReadMe 	:= new ReadMe().Parent(this)
	_MsgBox 	:= new MsgBox()
	;_TcCommand 	:= new TcCommand()	

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
		this._setUsername()
		this.Directory().path( $path )
		this.Repository().setUrl()
		;Dump(this, "this.", 1)

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
			this._run.push({ "cmd": this._commands[$cmd], "params": $params })
		else
			this.MsgBox().exit( "TcGit - ERROR", "COMMAND """ $cmd """ DOES NOT EXISTS.`n`nTcGit will exit." )
			
		return this
	}
	/** 
	 */
	init()
	{
		$result := this.cmd("init").cmd("ignorecase").run()
		;Dump($result, "result", 1)
		if( RegExMatch( $result, "^Initialized empty Git repository" ) )
			this.MsgBox().message($result)
		else
			this.MsgBox().exit( "Error occurred`n" $result)
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
		For $i, $cmd_obj in this._run
			$run_cmd	.= " &&git " $cmd_obj.cmd " " $cmd_obj.params
		return %$run_cmd% 
	}
	/** run commands
		@param string $commands
	 */
	_runCmd( $commands )
	{
		$cd_repository	:= "cd " this.Directory().path() 
		this._run	:= []

		return % ComObjCreate("WScript.Shell").Exec("cmd.exe /q /c " $cd_repository $commands ).StdOut.ReadAll()
		
	}

	
	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this 
	}
	
	
	
}