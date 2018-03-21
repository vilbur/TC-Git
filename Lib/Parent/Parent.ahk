/** Class Parent
*/
Class Parent extends Accessors
{
	static _Parent := {"address":""}
	
	/** set\get parent class
	 * @return object parent class
	*/
	Parent($Parent:=""){
		if($Parent)
			this._Parent.address	:= &$Parent
		return % $Parent ? this : Object(this._Parent.address)
	}
	
		
}
 