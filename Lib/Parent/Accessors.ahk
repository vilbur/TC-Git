/** Class Accessors
*/
Class Accessors
{

	/**
	 */
	Repository()
	{
		return % this.Parent()._Repository
	}
	/**
	 */
	Directory()
	{
		return % this.Parent()._Directory
	}
	/**
	 */
	ReadMe()
	{
		;MsgBox,262144,, ReadMe,2 
		return % this.Parent()._ReadMe
	}
	/**
	 */
	MsgBox()
	{
		;MsgBox,262144,, XXX,2 
		return % this.Parent()._MsgBox
	}
		
}
 