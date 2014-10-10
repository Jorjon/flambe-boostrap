package core.ui.loader ;
import core.ui.Controller;
import flambe.asset.Manifest;

/**
 * ...
 * @author Jorjon
 */
class LoaderModel{
    public var progress:Float;
    public var total:Float;
    public var manifest:Manifest;
    public var target:Controller;
    
    public function new(manifest:Manifest, target:Controller) {
        this.manifest = manifest;
        this.target = target;
    }
    
}