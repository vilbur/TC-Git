/** Class Repository
*/
Class Repository extends Parent
{
	_name	:= "" ; name of repository
	_url	:= ""
	/**
	 */
	setName()
	{
		SplitPath, % this.Parent()._path, $dir
		this._name	:= $dir
		return this
	} 
	/**
	 */
	setUrl()
	{
		this._url := "https://github.com/" this.Parent()._username "/" this._name
		return this		
	}
	
	/** Test if repository exitst
		https://autohotkey.com/board/topic/97102-how-to-check-if-a-url-exists-or-notproblem-with-urldownloadtofile/
	 */
	exists()
	{
		return % this._getUrlStatus( this._getRepositoryUrl ) == 200
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