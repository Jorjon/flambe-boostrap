package core.html;

import flambe.System;

class JSEmbedProxy
{

	public function new() 
	{
		// Nothing
	} 
	
	static public function alertOn( inString ) 
	{		
		callJSEmbedMethod("addAlert('"+inString+"', '')");
	}
	
	static public function alertOff() 
	{
		callJSEmbedMethod("removeAlert('')");
	}
	
	static public var exists( get_exists, never) : Bool;
	static public function get_exists() : Bool
	{
		return callJSEmbedMethod("exists()");
	}
	
	static public var parameters(get_parameters, never) : String;
	static public function get_parameters() : String
	{
		return callJSEmbedMethod("params()");
	}
	
	static public var attributes(get_attributes, never) : String;
	static public function get_attributes() : String
	{
		return callJSEmbedMethod("attr()");
	}
	
	static public var base(get_base, never) : String;
	static public function get_base() : String
	{
		return callJSEmbedMethod("baseUrl()");
	}
	
	static public var isCrossdomain(get_isCrossdomain, never) : Bool;
	static public function get_isCrossdomain() : Bool
	{
		return callJSEmbedMethod("isBaseCrossdomain()");
	}
		
	static public var scaleType(get_scaleType, never) : String;
	static public function get_scaleType() : String
	{
		return (callJSEmbedMethod("scaleType()"));
	}
	
	static public var canvasScale(get_canvasScale, never) : Float;
	static public function get_canvasScale() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("canvasScale()"));
	}
	
	static public var canvasWidth(get_canvasWidth, never) : Float;
	static public function get_canvasWidth() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("canvasWidth()"));
	}
	
	static public var canvasHeight(get_canvasHeight, never) : Float;
	static public function get_canvasHeight() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("canvasHeight()"));
	}
	
	static public var scaledWidth(get_scaledWidth, never) : Float;
	static public function get_scaledWidth() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("scaledWidth()"));
	}
	
	static public var scaledHeight(get_scaledHeight, never) : Float;
	static public function get_scaledHeight() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("scaledHeight()"));
	}

	static public var contentOffsetX(get_contentOffsetX, never) : Float;
	static public function get_contentOffsetX() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("contentOffsetX()"));
	}
	
	static public var contentOffsetY(get_contentOffsetY, never) : Float;
	static public function get_contentOffsetY() : Float
	{
		return Std.parseFloat(callJSEmbedMethod("contentOffsetY()"));
	}
	
	static public var isPaused(get_isPaused, never) : Bool;
	static public function get_isPaused() : Bool
	{
		return callJSEmbedMethod("isPaused()");
	}
	
	static public var embedDiv(get_embedDiv, never) : Dynamic;
	static public function get_embedDiv() : Dynamic
	{
		return callJSEmbedMethod("embedDiv()");
	}
	
	static public var embedDivId(get_embedDivId, never) : String;
	static public function get_embedDivId() : String
	{
		return callJSEmbedMethod("embedDivId()");
	}
	
	static public function pause() 
	{
		callJSEmbedMethod("pause()");
	}
	
	static public function unpause()
	{
		callJSEmbedMethod("unpause()");
	}
	
	static public function inform( inString ) 
	{
		callJSEmbedMethod("inform("+inString+")");	
	}
	
	static public function informConstructed() 
	{
		callJSEmbedMethod("informConstructed()");
	}
	
	static public function informInitialized() 
	{
		callJSEmbedMethod("informInitialized()");
	}
	
	static public function informReady() 
	{
		callJSEmbedMethod("informReady()");
	}
	
	static public function setScale( inScale ) 
	{
		callJSEmbedMethod("setScale("+Std.string(inScale)+")");
	}
	
	static public function setDimensions( inWidth, inHeight )
	{
		callJSEmbedMethod("setScale("+Std.string(inWidth)+","+Std.string(inHeight)+")");
	}
	
	static public function setCanvasScaleMax( inCanvasScaleMax:Float ) : Void
	{
		callJSEmbedMethod("setCanvasScaleMax("+Std.string(inCanvasScaleMax)+")");
	}
	
	static public function callJSEmbedMethod( pRequest:String ) : Dynamic
	{
		// Make sure you include () parenthesis and any parameters needed by the method.
		#if js	
			try
			{						
				var result = (js.Lib.eval("jsembed."+pRequest));
				return result==null?"":result;						
			} catch( err:Dynamic )
			{
				// Nothing
				//trace("[JSEmbedProxy](callJSEmbedMethod) Error: JSEmbed missing, or can't handle request : " + ("jsembed."+pRequest));
			}
		#elseif flash
			// Warning: Largely untested. JSEmbed doesn't embed flash, so this is present only for edge cases.
			try
			{				
				var result = (System.external.call("eval",["jsembed."+pRequest]));
				return result==null?"":result;			
			} catch( err:Dynamic)
			{
				// Nothing
			}
		#end 
		
		return "";
		
	}
	
} 
