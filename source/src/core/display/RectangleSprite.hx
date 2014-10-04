package core.display;
import flambe.display.Graphics;
import flambe.display.Sprite;

/**
 * ...
 * @author Jorjon
 */
class RectangleSprite extends Sprite{
    public var stroke:Int;
    public var h:Float;
    public var w:Float;
    public var color:Int;

    public function new(?color:Int, ?x:Float, ?y:Float, ?w:Float, ?h:Float) {
        super();
        this.h = h;
        this.w = w;
        this.x._ = x;
        this.y._ = y;
        this.color = color;
    }
    
    public function setStroke(value:Int):RectangleSprite {
        this.stroke = value;
        return this;
    }
    
    public function setColor(color:Int):RectangleSprite {
        this.color = color;
        return this;
    }
    
    override public function draw(g:Graphics) {
        if (stroke > 0) {
            g.fillRect(color, 0, 0, w - stroke, stroke);
            g.fillRect(color, 0, h - stroke, w, stroke);
            g.fillRect(color, 0, 0, stroke, h - stroke);
            g.fillRect(color, w - stroke, 0, stroke, h - stroke);
        } else {
            g.fillRect(color, 0, 0, w, h);
        }
    }
    
}