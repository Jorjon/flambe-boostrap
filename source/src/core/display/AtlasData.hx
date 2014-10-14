package core.display;
import flambe.display.Texture;
import flambe.math.Rectangle;

/**
 * ...
 * @author Jorjon
 */
class AtlasData{
    public var name:String;
    public var trimmed:Bool;
    public var rotated:Bool;
    public var frame:Rectangle;
    public var spriteSourceSize:Rectangle;
    public var sourceSize:Rectangle;
    public var texture:Texture;
    
    public function new(name:String, trimmed:Bool, rotated:Bool, frame:Rectangle, spriteSourceSize:Rectangle, sourceSize:Rectangle, texture:Texture) {
        this.name = name;
        this.trimmed = trimmed;
        this.rotated = rotated;
        this.frame = frame;
        this.spriteSourceSize = spriteSourceSize;
        this.sourceSize = sourceSize;
        this.texture = texture;
    }
    
}