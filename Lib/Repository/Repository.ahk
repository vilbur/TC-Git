/** Class Repository
*/
Class Repository extends Parent
{
	static _git_url	:= "https://github.com/" 
	_url	:= "" ; url to repository
	_name	:= "" ; name of repository
	
	/**
	 */
	name( $url:="" )
	{
		if( ! $url )
			return this._name
		
		this._name	:= RegExReplace( this._url, ".*/([^/]+)$", "$1" )  
		return this
	}
	/** 
	 */
	getOrigin()
	{
		return % RegExReplace( this.Parent()._runCmd( " &&git config --get remote.origin.url" ), "\s+$", "" ) 		
	}	
	/** set url to repository
		try to find repository, if $repository_url not defined or url not exist
	 */
	setUrl( $url:="" )
	{
		if( this.exists( $url ) )
			this._url := $url

		else if( $url!="init" )
			this._url := this.getOrigin()

		if( ! this.exists( this._url ) )
			this._url := this._findUrl()
		
		this.name( this._url )
		
		if( ! RegExMatch( this._url, "\.git$") )
			this._url := this._url ".git"
		
		return this
	}
	/** get url inside tree E.G.: https://github.com/vilbur/Repository/tree/master/subfolder
	 */
	getTreeUrl()
	{
		$rx_root	:= RegExReplace( this.Directory().path(), "[\\\/]", "\\" )
		$relative_path	:= RegExReplace( this.Directory().path("current") , $rx_root , "/tree/master" )
		$url 	:= RegExReplace( this._url, "\.git$", "" )
		return % $url RegExReplace( $relative_path, "[\\]+", "/" )
		
	}
	/** Try set url combining username, folder name
	 */
	_findUrl()
	{
		$url	:= this._git_url this.Parent()._username "/" this.Directory().name()

		if( ! this.exists($url) )
			$url := this._getUrlByPrefixes( $url )
		
		$url := $url ? this._confirmUrl( $url ) : this._askForUrl()
		
		return %$url%		
	}
	/**
	 */
	_confirmUrl( $url )
	{
		$url := this.MsgBox().input("Git repository", "Is this url correct ?", {default:$url} )
		
		this._exitIfCanceled( $url )
			
		if ( ! this.exists($url) )
			return % this._askForUrl( $url )

		return %$url%		
	}
	/**
	 */
	_askForUrl( $url:="" )
	{
		While, ! this.exists($url) {
			$url := this.MsgBox().input("Git repository", "Set url to repository", {default:$url} )
			this._exitIfCanceled( $url )		
		}
		;return %$url%		
		$url :=  RegExReplace( $url, "\s+$", "")
		
		;return % RegExMatch( $url, "\.git$") ? $url : $url ".git"
		return $url 
	}
	/**
	 */
	_exitIfCanceled( $url )
	{
		if($url==0)
			exitApp
	} 
	
	/** Try find url combining username, prefix from ini and folder name
	 */
	_getUrlByPrefixes( $url )
	{
		$prefixes	:= this.Ini().getKeys("prefixes")
		;Dump($prefixes, "prefixes", 1)
		For $i, $prefix in $prefixes {
			$url	:= this._git_url this.Parent()._username "/" $prefix this.Directory().name()
			;Dump($url, "url", 1)
			if( this.exists( $url ) )
				return %$url% 
		}
	}
	
	/** Test if repository exitst
		https://autohotkey.com/board/topic/97102-how-to-check-if-a-url-exists-or-notproblem-with-urldownloadtofile/
	 */
	exists( $url )
	{
		return % this._getUrlStatus( RegExReplace( $url, "\.git$", "") ) == 200
	}
	/*
	 */
	_getUrlStatus( $URL, $Timeout = -1 )
	{
		ComObjError(0)
		static WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	
		WinHttpReq.Open("HEAD", $URL, True)
		WinHttpReq.Send()
		WinHttpReq.WaitForResponse($Timeout) ; Return: Success = -1, $Timeout = 0, No response = Empty String
	
		Return, WinHttpReq.Status()
	}


	
	
}