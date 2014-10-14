package core.display;

/**
 * ...
 * @author Jorjon
 */
class AnimationData {
    public var name:String;
    public var frames:Array<AtlasData>;
    
    public function new(name:String, frames:Array<AtlasData>) {
        this.name = name;
        this.frames = frames;
    }
    
}