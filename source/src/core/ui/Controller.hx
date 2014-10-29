package core.ui;
import flambe.animation.Ease;
import flambe.display.Sprite;
import flambe.Entity;
import flambe.scene.FadeTransition;
import flambe.scene.Scene;
import flambe.scene.SlideTransition;
import flambe.scene.Transition;

/**
 * ...
 * @author Jorjon
 */
class Controller implements IState{

    public var inited:Bool;
    var context:Context;
	
	public function new(context:Context) {
		this.context = context;
	}
    
    public function setupView():Void {
        // override
    }
    
	function setupWidgets():Void {
		// override
	}
	
	function centerWidget(widget:Sprite, horizontal:Bool = true, vertical:Bool = true):Void {
		if (horizontal) widget.x._ = widget.x._ + (960 - widget.getNaturalWidth()) / 2;
		if (vertical) widget.y._ = widget.y._ + (480 - widget.getNaturalHeight()) / 2;
	}
    
    function showView(view:View, transition:String = "none"):Void {
        var e_scene:Entity = new Entity();
        e_scene.add(new Scene(view.opaque));
        e_scene.addChild(view.owner);
        context.states.showView(e_scene, getTransition(transition));
    }
    
    function getTransition(transition:String):Transition {
		switch (transition) {
			case "left": return new SlideTransition(.5, Ease.quintInOut).left();
			case "right": return new SlideTransition(.5, Ease.quintInOut).right();
            case "fade": return new FadeTransition(.5, Ease.quintInOut);
            case "none": return null;
		} return null;
	}
    
    public function update(dt:Float){
        // override
    }
	
    /* INTERFACE core.ui.IState */
    
    public function init():Void {
        // override
    }
    
    public function activate():Void {
        // override
    }
    
    public function deactivate():Void {
        // override
    }
    
    public function deinit():Void {
        // override
    }
	
}