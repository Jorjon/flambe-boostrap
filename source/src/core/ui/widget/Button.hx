package core.ui.widget;

import flambe.display.Sprite;
import flambe.input.PointerEvent;
import flambe.math.Point;

/**
 * ...
 * @author Jorjon
 */
class Button extends Sprite{

    /// Use MouseUp for triggering events.
    public var useMouseUp:Bool = true;
    private var origin:Point;
    private var callback:PointerEvent->Void;
    
    public function new() {
        super();
		pointerDown.connect(onDown, true);
        pointerUp.connect(onUp, true);
    }
    
    public function setCallback(onClick:PointerEvent->Void):Button {
        callback = onClick;
        return this;
    }
    
    private function onUp(e:PointerEvent):Bool {
        if (origin == null) return false;
        //x.animateTo(origin.x - 0.5, .1);
        y.animateTo(origin.y - 2, .1);
        
        if (useMouseUp) processCallback(e);
        
        return true;
    }
    
    private function onDown(e:PointerEvent):Bool {
        // we will use the click, thanks
        e.stopPropagation();
        
        if (origin == null) {
            origin = new Point(x._, y._);
        }
        
        //x.animateTo(origin.x + 0.5, .1);
        y.animateTo(origin.y + 2, .1);
        
        if (!useMouseUp) processCallback(e);
        
        return true;
    }
    
    inline private function processCallback(e:PointerEvent):Void {
        if (callback != null) callback(e);
    }
    
}