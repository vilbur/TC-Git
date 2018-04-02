#Include %A_LineFile%\..\Includes.ahk

/** Class TcGit
*/
Class TcGit extends Accessors
{
	;;;_Ini 	:= new Ini( A_ScriptDir "\TcGit.ini" )
	_Ini 	:= new Ini()		
	_Repository 	:= new Repository().Parent(this)	
	_Directory 	:= new Directory().Parent(this)
	_GitIgnore 	:= new GitIgnore().Parent(this)
	_ReadMe 	:= new ReadMe().Parent(this)	
	_MsgBox 	:= new MsgBox()

	_username	:= ""	
	
	_commands :=	{"git":	"git"
		,"init":	"init"
		,"ignorecase":	"config core.ignorecase false"
		,"add-all":	"add ."
		;,"push":	"origin master"		
		,"pull":	"pull origin master"
		,"fetch":	"fetch --all"
		,"commit":	""
		,"reset":	"--hard origin/master"
		,"remote-add":	"remote add origin"
		,"remote-set":	"set-url origin"		
		,"":	""}
	
	_commands_run	:= [] ; commands to _run
	
	/**
	  * @param string $parameter 
	  *
	  *		search:	default, search .git folder
	  *		init:	will find url to repository
	  *		do nothing:	for create readme
	  *
	  */
	__New( $parameter )
	{
		this._setUsername()

		if( ! RegExMatch( $parameter, "i)(create-dir|create-readme)" ) )
		{
			this._Directory.setRoot($parameter)
			this._Repository.setUrl($parameter)
		}
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
		this._savePrefix()		

		$origin	:= this._Repository.getOrigin()

		$result	:= this.cmd("init")
					.cmd("ignorecase")
					.cmd($origin ? "remote-set" : "remote-add", this._Repository._url)
					.run()
		
		if( RegExMatch( $result, "^Initialized empty Git repository" ) )
			if( this.MsgBox().confirm("PULL DATA", $result "`n`n       Do You want PULL data ?", 10) )
				this.cmd("pull").run()
			
		else
			this.MsgBox().exit( "Error occurred`n" $result)
			
		
			
		return this
	}
	/** open GitHub repository in browser
	  *
	  * open on url in current subfolder,
	  * open in root if Control key is pressed
	 */
	openBrowser()
	{
		
		$control_key	:= GetKeyState("control", "P") 

		$url := $control_key || this.Directory().path()==this.Directory().path("current") ? this._Repository._url : this._Repository.getTreeUrl()

		Run %$url%
	}
	/** open GitKraken
	  * close other instances on ctrl key pressed
	  *
	  * @param boolean $control_key
	 */
	openKraken( $control_key )
	{
		if( $control_key )
			Run, taskkill /im gitkraken.exe /f,,hide

		
		$kraken_highest_version := ""
		loop, %AppData%\..\Local\gitkraken\*.*, 2, 0
			if( RegExMatch( A_LoopFileName  , "i)app-.*" ) )
				$kraken_highest_version := A_LoopFileName
			 
		if( $kraken_highest_version ){
			$path = %AppData%\..\Local\gitkraken\%$kraken_highest_version%\gitkraken.exe
			Run,  % $path " -p """ this.Directory().path() """"
		}
			
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
	;_initUrl(){
	;	this._setUsername()
	;	;this._Repository.setUrl()
	;	this._savePrefix()
	;}
	
	/**
	 */
	_savePrefix()
	{
		$repository_name	:= this._Repository.name()
		$directory_name	:= this._Directory.name()
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
		$cd_repository	:= "cd " this._Directory.path() 
		this._commands_run	:= []
		;MsgBox,262144,$commands, %$commands%
		;MsgBox,262144,cd_repository, %$cd_repository%
		;MsgBox,262144,cd_repository, %  $cd_repository $commands 
		return % ComObjCreate("WScript.Shell").Exec("cmd.exe /q /c " $cd_repository $commands ).StdOut.ReadAll()
	}

	/** set\get parent class
	 * @return object parent class
	*/
	Parent(){
		return this 
	}
	
	
	
}