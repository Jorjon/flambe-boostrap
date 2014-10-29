package core.display;

/**
 * ...
 * @author Jorjon
 */
class AnimationData {
    public var name:String;
    public var frames:Array<AtlasData>;
    public var labels:Map<String, Int>;
    
    public function new(name:String, frames:Array<AtlasData>, labels:Map<String, Int>) {
        this.labels = labels;
        this.name = name;
        this.frames = frames;
    }
    
}