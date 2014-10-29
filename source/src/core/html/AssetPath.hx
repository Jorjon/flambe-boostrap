package core.html;
import flambe.asset.Manifest;

/**
 * ...
 * @author Jorjon
 */
class AssetPath{

    static var baseUrl:String = "";
    
    public function new() {
        
    }
    
    static public function setup(manifest:Manifest):Void {
        if ( baseUrl != "" ) {
			if (JSEmbedProxy.isCrossdomain)
			{
				manifest.remoteBase = baseUrl;
			} else {
				manifest.localBase = baseUrl;
			}
		}
    }
    
    public static function setupBaseURL() {
		#if js
			if(JSEmbedProxy.exists)
			{			
				// Set crossdomain base URL.
				if(JSEmbedProxy.isCrossdomain)
				{
					baseUrl = appendAssetsToUrl(JSEmbedProxy.base);
				} else {			
					baseUrl = trimUrl(JSEmbedProxy.base);
				}							
			} else {
				baseUrl = "";	
			}
		#else			
			baseUrl = "";
		#end
	}
 
	
	// Trim the domain off of the supplied url
	static function trimUrl( url:String ) : String
	{
		if(url==""){return "";}
		if(url.indexOf("http")<0)
		{
			if(url.charAt(0)=="/")
			{
				url = url.substr(1, url.length-1);
			}
			return url;
		}
		var tStartIndex = url.indexOf("http://");
		if(tStartIndex<0)
		{
			tStartIndex = url.indexOf("https://");
			if(tStartIndex<0)
			{
				// This should be impossible. 
				tStartIndex=0;
			} else {
				tStartIndex += 8;
			}
		} else {
			tStartIndex += 7;
		}
		
		var tEndIndex = url.indexOf("/", tStartIndex);		
		
		var result = url.substr(tEndIndex, url.length - tEndIndex);
				
		result = appendAssetsToUrl(result);		
		 											
		return result;
		
	}
	// Append the "assets" tag to the url
	static function appendAssetsToUrl( url:String) : String
	{		
		//if(url.length==0){return url;}
		if(url.charAt(url.length-1)!="/")
		{
			url = url + "/";
		}
		url = url + "assets/";
		return url;
	}
    
}