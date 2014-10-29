package core.display;
import core.resource.Resources;
import flambe.display.Graphics;
import flambe.display.Sprite;
import flambe.display.Texture;
import flambe.math.Rectangle;
import haxe.Json;

/**
 * ...
 * @author Jorjon
 */
class AtlasAnimationSprite extends Sprite{

    public var frameRate:Float = 15;
    var currentAnimation:AnimationData;
    var currentFrame:AtlasData;
    var nextAnimation:AnimationData;
    var loadedAnimations:Map<String, AnimationData>;
    var atlasesData:Map<String, AtlasData>;
    var atlasTexture:Texture;
    var currentTime:Float;
    var resources:Resources;
    var repeat:Bool;
    var stopped:Bool;
    public var current(get, null):String;
    var callbacks:Map < String, String -> Void >;
    var lastFrameIndex:Int;

    public function new(resources:Resources) {
        super();
        this.resources = resources;
        stopped = false;
        callbacks = new Map < String, String -> Void > ();
    }
    
    public function getLabelPosition(animation:String, label:String):Int {
        return loadedAnimations[animation].labels[label];
    }
    
    function objectToRectangle(object:Dynamic):Rectangle {
        return new Rectangle(object.x, object.y, object.w, object.h);
    }
    
    /**
     * Calls a function when any of loaded animations reaches this label.
     * @param label
     */
    public function setLabelCallback(label:String, callback:String -> Void):Void {
        callbacks[label] = callback;
    }
    
    public function load(id:String):AtlasAnimationSprite {
        var animationDataJson = Json.parse(resources.getFile(id + ".json").toString());
        var atlasDataJson = Json.parse(resources.getFile(animationDataJson.source).toString());
        var atlasTexture = resources.getTexture(atlasDataJson.meta.image.substr(0, atlasDataJson.meta.image.lastIndexOf(".")));
        atlasesData = new Map<String, AtlasData>();
        for (i in Reflect.fields(atlasDataJson.frames)) {
            var name:String = i;
            var data:Dynamic = Reflect.field(atlasDataJson.frames, i);
            atlasesData[name] = new AtlasData(name, data.trimmed, data.rotated, objectToRectangle(data.frame), objectToRectangle(data.spriteSourceSize), objectToRectangle(data.sourceSize), atlasTexture);
        }
        loadedAnimations = new Map<String, AnimationData>();
        for (i in Reflect.fields(animationDataJson.animations)) {
            var filter:String;
            var labels:Map<String, Int> = new Map<String, Int>();
            var animationsData:Dynamic = Reflect.field(animationDataJson.animations, i);
            
            // If `animations` is a string
            if (Std.is(animationsData, String)) {
                
                // Filter is the default setting value.
                filter = Std.string(animationsData);
            
            // If `animations` is an object, assume more settings
            } else {
                
                // Filter should be always included
                filter = animationsData.filter;
                
                // TODO: Labels need to be numerically sorted in ascended way, so we can check for
                // the next label instead of traversing the entire label array each frame.
                if (Reflect.hasField(animationsData, "labels")) {
                    for (label in Reflect.fields(animationsData.labels)) {
                        // Labels are stored in base 0, must be declared in base 1.
                        labels[label] = Std.parseInt(Reflect.field(animationsData.labels, label)) - 1;
                    }
                }
                
            }
            // Gather all frames. Expands %c to search a digit like 000, 001,
            // 002, etc; inside the animation list.
            var j = 0, frame, frameList = new Array<AtlasData>();
            while ((frame = atlasesData.get(StringTools.replace(filter, "%c", StringTools.lpad(Std.string(j), "0", 3)))) != null) {
                frameList.push(frame);
                j++;
            }
            
            loadedAnimations[i] = new AnimationData(i, frameList, labels);
        }
        return this;
    }
    
    public function play(name:String, repeat:Bool = true):AtlasAnimationSprite {
        this.repeat = repeat;
		currentTime = 0;
        playData(loadedAnimations[name]);
        return this;
    }
    
    public function playNext(name:String, repeat:Bool = true):Void {
        nextAnimation = loadedAnimations[name];
    }
    
    public function pause():Void {
        
    }
    
    public function resume():Void {
        
    }
    
    public function stop():Void {
        stopped = true;
    }
    
    override public function onUpdate(dt:Float) {
        super.onUpdate(dt);
        if (stopped) return;
        var currentFrameIndex = Math.floor(currentTime * frameRate);
        
        // Check labels. Check from last to current so we don't miss any label if animation is fast.
        // Doesn't support multiple labels in the same frame.
        // TODO: Avoid traversing entire array by ordering labels (or callbacks).
        //trace(currentAnimation.name, lastFrameIndex, currentFrameIndex, currentAnimation.labels, callbacks);
        for (i in currentAnimation.labels.keys()) {
            if (currentAnimation.labels[i] > lastFrameIndex &&
                currentAnimation.labels[i] <= currentFrameIndex &&
                callbacks.exists(i))
                callbacks[i](currentAnimation.name);
        }
        lastFrameIndex = currentFrameIndex;
        if (currentFrameIndex >= currentAnimation.frames.length) {
            // If we passed through the limit, we cycle the animation
            currentTime -= currentAnimation.frames.length / frameRate;
            if (nextAnimation != null) {
                playData(nextAnimation);
            } else if (!repeat) {
                stop();
            }
        } else {
            currentFrame = currentAnimation.frames[currentFrameIndex];
        }
        currentTime += dt;
    }
    
    function playData(data:AnimationData):Void {
        currentAnimation = data;
        lastFrameIndex = -1;
        currentFrame = currentAnimation.frames[0];
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
    
    function get_current():String {
        return currentAnimation.name;
    }
    
}