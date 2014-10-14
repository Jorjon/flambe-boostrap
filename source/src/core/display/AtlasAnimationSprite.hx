package core.display;
import flambe.display.Graphics;
import flambe.display.Sprite;
import flambe.display.Texture;
import flambe.math.Rectangle;

/**
 * ...
 * @author Jorjon
 */
class AtlasAnimationSprite extends Sprite{

    public var frameRate:Float = 60;
    public var sourceFile(get, null):String;
    public var sourceImage(get, null):String;
    var currentAnimation:AnimationData;
    var currentFrameIndex:Int;
    var currentFrame:AtlasData;
    var nextAnimation:AnimationData;
    var loadedAnimations:Map<String, AnimationData>;
    var animationDataJson:Dynamic;
    var atlasDataJson:Dynamic;
    var atlasesData:Map<String, AtlasData>;
    var atlasTexture:Texture;

    public function new() {
        super();
    }
    
    function get_sourceFile():String {
        return animationDataJson.source;
    }
    
    function get_sourceImage():String {
        return atlasDataJson.meta.image.substr(0, atlasDataJson.meta.image.lastIndexOf("."));
    }
    
    public function loadAnimationData(json:Dynamic):AtlasAnimationSprite {
        animationDataJson = json;
        return this;
    }
    
    function objectToRectangle(object:Dynamic):Rectangle {
        return new Rectangle(object.x, object.y, object.w, object.h);
    }
    
    public function loadSourceData(json:Dynamic):AtlasAnimationSprite {
        atlasDataJson = json;
        return this;
    }
    
    function invalidate():AtlasAnimationSprite {
        atlasesData = new Map<String, AtlasData>();
        for (i in Reflect.fields(atlasDataJson.frames)) {
            var name:String = i;
            var data:Dynamic = Reflect.field(atlasDataJson.frames, i);
            atlasesData[name] = new AtlasData(name, data.trimmed, data.rotated, objectToRectangle(data.frame), objectToRectangle(data.spriteSourceSize), objectToRectangle(data.sourceSize), atlasTexture);
        }
        loadedAnimations = new Map<String, AnimationData>();
        for (i in Reflect.fields(animationDataJson.animations)) {
            var filter:String = Reflect.field(animationDataJson.animations, i);
            // Gather all frames. Expands %c to search a digit like 000, 001, 002, etc; inside the animation list.
            var j = 0, frame, frameList = new Array<AtlasData>();
            while ((frame = atlasesData.get(StringTools.replace(filter, "%c", StringTools.lpad(Std.string(j), "0", 3)))) != null) {
                frameList.push(frame);
                j++;
            }
            
            loadedAnimations[i] = new AnimationData(i, frameList);
        }
        return this;
    }
    
    public function loadImageData(texture:Texture):AtlasAnimationSprite {
        atlasTexture = texture;
        return invalidate();
    }
    
    public function play(name:String):Void {
        playData(loadedAnimations[name]);
    }
    
    public function playNext():Void {
        
    }
    
    public function pause():Void {
        
    }
    
    public function resume():Void {
        
    }
    
    public function stop():Void {
        
    }
    
    override public function onUpdate(dt:Float) {
        var rate:Float = 1 / frameRate;
        if (currentFrameIndex == currentAnimation.frames.length) {
            currentFrameIndex = 0;
            if (nextAnimation != null) {
                playData(nextAnimation);
            }
        } else {
            currentFrame = currentAnimation.frames[currentFrameIndex];
        }
        currentFrameIndex++;
    }
    
    function playData(data:AnimationData):Void {
        currentAnimation = data;
        currentFrame = currentAnimation.frames[currentFrameIndex];
    }
    
    override public function draw(g:Graphics) {
        g.drawSubTexture(currentFrame.texture, currentFrame.spriteSourceSize.x, currentFrame.spriteSourceSize.y, currentFrame.frame.x, currentFrame.frame.y, currentFrame.frame.width, currentFrame.frame.height);
    }
    
    override public function getNaturalWidth():Float {
        return currentFrame.sourceSize.width;
    }

    override public function getNaturalHeight():Float {
        return currentFrame.sourceSize.height;
    }
    
}