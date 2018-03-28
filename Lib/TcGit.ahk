#Include %A_LineFile%\..\Includes.ahk

/** Class TcGit
*/
Class TcGit extends Accessors
{
	;_Ini 	:= new Ini( A_ScriptDir "\TcGit.ini" )
	_Ini 	:= new Ini()		
	_Repository 	:= new Repository().Parent(this)	
	_Directory 	:= new Directory().Parent(this)
	_GitIgnore 	:= new GitIgnore().Parent(this)
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
	
	_commands_run	:= [] ; commands to _run
	
	__New()
	{
		;Dump(this, "this.", 1)
	}
	/**
	 */
	cmd( $cmd, $params:="" )
	{
		if( this._commands.hasKey($cmd) )
			this._commands_run.push({ "cmd": this._commands[$cmd], "params": $params })
		else
			this.MsgBox().exit( "TcGit - ERROR", "COMMAND """ $cmd """ DOES NOT EXISTS.`n`n		TcGit will exit." )
			
		return this
	}
	/**
	 */
	run()
	{
		return % this._runCmd( this._joinCommands() )
	}
	
	/** INIT FOLDER, IGNORE CASE, SET URL
	 */
	init()
	{
		this._initUrl()
		
		$origin	:= this.Repository().getOrigin()
		;MsgBox,262144,origin, %$origin%,3 
		;$remote_cmd	:= $origin ? "remote-set" : "remote-add"
		$result	:= this.cmd("init")
					.cmd("ignorecase")
					.cmd($origin ? "remote-set" : "remote-add", this.Repository()._url)
					.run()

		
		if( RegExMatch( $result, "^Initialized empty Git repository" ) )
			this.MsgBox().message($result, 10)
		else
			this.MsgBox().exit( "Error occurred`n" $result)
	}


	
	;;;;/** Add or set remote url if exists
	;;; * CURRENTLY UNUSED
	;;; * 
	;;; */
	;;;setRemote()
	;;;{
	;;;	$origin	:= this.Repository().getOrigin()
	;;;	$cmd	:= $origin ? "remote-set" : "remote-add"
	;;;	$result	:= this.cmd($cmd, this.Repository()._url)._run()		
	;;;}
	
	
	/*
	-----------------------------------------------
		PRIVATE METHODS
	-----------------------------------------------
	*/
	_initUrl(){
		this._setUsername()
		this.Repository().setUrl()
		this._savePrefix()
	}
	
	/**
	 */
	_savePrefix()
	{
		$repository_name	:= this.Repository().name()
		$directory_name	:= this.Directory().name()
		if ( $repository_name != $directory_name && RegExMatch( $repository_name, "i)" $directory_name ) )
			this._Ini.set( "prefixes", RegExReplace( $repository_name, "i)(.*-)" $directory_name, "$1" )   )
	}
	/**
	 */
	_setUsername()
	{
		this._username := this._Ini.get( "config", "username" )
	} 
	
	
	/** 
	 */
	_joinCommands()
	{
		For $i, $cmd_obj in this._commands_run
			$run_cmd	.= " &&git " $cmd_obj.cmd " " $cmd_obj.params
		return %$run_cmd% 
	}
	/** _run commands
		@param string $commands
	 */
	_runCmd( $commands )
	{
		$cd_repository	:= "cd " this.Directory().path() 
		this._commands_run	:= []
		;MsgBox,262144,$commands, %$commands% 
		return % ComObjCreate("WScript.Shell").Exec("cmd.exe /q /c " $cd_repository $commands ).StdOut.ReadAll()
	}

	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this 
	}
	
	
	
}