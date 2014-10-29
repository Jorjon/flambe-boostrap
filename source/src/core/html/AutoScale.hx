package core.html;
import flambe.Component;
import flambe.display.Sprite;
/**
 * ...
 * @author Ang Li
 */

class AutoScale extends Component
{
	public static var SCALE : Float = 1;
	#if js
	var _scaleSprite : Sprite;

	public function new() 
	{
	}
	
	override public function onAdded() 
	{
		_scaleSprite = owner.get(Sprite);
	}
	
	override public function onUpdate(dt:Float) 
	{
		var tmp  = JSEmbedProxy.canvasScale;
		SCALE = tmp;
		if ( (tmp != null)&& tmp != _scaleSprite.scaleX._ )
		{
			_scaleSprite.scaleX._ = tmp;
			_scaleSprite.scaleY._ = tmp;
		}
	}
	#end
}
