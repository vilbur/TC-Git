
global $MsgBoxActiveWindowID

/** Class MsgBox
*/
Class MsgBox
{

	_title	:= ""
	_message	:= ""
	_timeout	:= ""
	_button	:= ""		
	
	/** Show message box centered to window
		@params
			$title
			$message
			$timeout 
	 */
	message( $params* )
	{
		this._setParams($params)
		this._centerToWindow()				
		MsgBox,262144, % this._title , % this._message, % this._timeout
		return this
	}
	/** Show confirm box centered to window
			$title
			$message
			$button			
			$timeout 
	 */
	confirm( $params* )
	{
		this._setParams($params)
		this._centerToWindow()

		if(RegExMatch( this._button, "i)yes" ))
			MsgBox, 4, % this._title , % this._message, % this._timeout
		else	
			MsgBox,260, % this._title , % this._message, % this._timeout
		
		IfMsgBox, Yes
			return true		 
	}
	/**
	 */
	_setParamsDefaults()
	{
		this._title	:= RegExReplace( A_ScriptName, "i)\.(ahk|exe)$", "" ) 
		this._timeout	:= 0
		this._button	:= "yes"
	}
	/**
	 */
	_setParams( $params )
	{
		$length	:= $params.Length()
		
		this._setParamsDefaults()
		this._setButtonParam($params)		
		
		if($length==1)
			this._message := $params[1]
		
		if($length>=2){
			this._title 	:= $params[1]
			this._message	:= $params[2]
		}
		
		if $params[$params.Length()] is number
			this._timeout	:= $params[$params.Length()]
	}
	/**
	 */
	_setButtonParam( $params )
	{
		For $i, $param in $params
			if( RegExMatch( $param, "i)^(yes|no)$", $button ) )
				this._button := $button

	} 
	/**
	 */
	_centerToWindow()
	{
		WinGet, $MsgBoxActiveWindowID, ID, A
		OnMessage(0x44, "centerMsgToWinow")
	} 
	
	
}

/* OnMessage Callback
*/
centerMsgToWinow($wParam)
{
	WinGetPos, $X, $Y, $W, $H, ahk_id %$MsgBoxActiveWindowID%
    if ($wParam = 1027) { ; AHK_DIALOG
        Process, Exist
        DetectHiddenWindows, On
        if WinExist("ahk_class #32770 ahk_pid " . ErrorLevel) {
			WinGetPos,,, $mW, $mH, A
			WinMove, ($W-$mW)/2 + $X, ($H-$mH)/2 + $Y -128
        }
    }
}