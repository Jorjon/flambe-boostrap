package core.ui.widget;

import core.audio.Audio;
import core.audio.AudioChannel;
import flambe.display.ImageSprite;
import flambe.display.Texture;
import flambe.input.PointerEvent;
import flambe.math.Point;

/**
 * ...
 * @author Jorjon
 */
class Button extends ImageSprite{

    /// Use MouseUp for triggering events.
    public var useMouseUp:Bool = true;
    private var origin:Point;
    private var callback:PointerEvent->Void;
    var normal:Texture;
    var hover:Texture;
    
    public function new(normal:Texture, ?hover:Texture) {
        super(normal);
        this.hover = hover;
        this.normal = normal;
        pointerIn.connect(onIn);
        pointerOut.connect(onOut);
		pointerDown.connect(onDown, true);
        pointerUp.connect(onUp, true);
    }
    
    public function setCallback(onClick:PointerEvent->Void):Button {
        callback = onClick;
        return this;
    }
    
    private function onIn(e:PointerEvent):Bool {
        if (hover != null) {
            texture = hover;
        }
        return true;
    }
    
    private function onOut(e:PointerEvent):Bool {
        texture = normal;
        if (origin == null) return false;
        y.animateTo(origin.y - 2, .1);
        return true;
    }
    
    private function onUp(e:PointerEvent):Bool {
        if (origin == null) return false;
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
        if (callback != null) {
            // TODO: use a different approach, dont depend on Audio.
            Audio.play("button", AudioChannel.UI);
            callback(e);
        }
    }
    
    function get_image():ImageSprite {
        return owner.firstChild.get(ImageSprite);
    }
    
}