package core.ui;
import core.resource.Resources;
import core.ui.widget.Button;
import core.ui.widget.MuteButton;
import flambe.display.Font;
import flambe.display.Font.TextAlign;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.display.TextSprite;
import flambe.display.Texture;
import flambe.Entity;
import flambe.input.PointerEvent;
import flambe.System;
import flambe.util.SignalConnection;

/**
 * @TODO: views should be completely detached from controllers, or they should be completely attached (no model involved).
 * @author Jorjon
 */
class View extends Sprite {

    public var opaque:Bool = true;
	var bground:Texture;
    var resources:Resources;
    var systemTouch:SignalConnection;
    var systemTouchCallback:PointerEvent -> Void;

    public function new(resources:Resources, ?background:String) {
        super();
        new Entity().add(this);
        this.resources = resources;
        if (background != null) {
            bground = resources.getTexture(background, true);
        }
    }
    
    
    /// create an image and add it to the screen
	function createImage(asset:String, append:Bool = true):ImageSprite {
		var sprite = createImage2(asset);
		owner.addChild(new Entity().add(sprite), append);
		return sprite;
	}
    
    /// Add a sprite to the screen
    function addSprite(sprite:Sprite, append:Bool = true):Sprite {
        owner.addChild(new Entity().add(sprite), append);
        return sprite;
    }
    
	/// create an image
	function createImage2(asset:String):ImageSprite {
		return cast new ImageSprite(asset == "" ? null : resources.getTexture(asset)).disablePointer();
	}
	
	/// create a text
	function createText2(text:String, font:String = "arial", ?align:TextAlign, ?wrap:Float):TextSprite {
		var textSprite:TextSprite = cast new TextSprite(new Font(resources.findFile(font + ".fnt"), font), text).disablePointer();
		if (align != null) textSprite.align = align;
		if (wrap != null) textSprite.wrapWidth._ = wrap;
		owner.addChild(new Entity().add(textSprite));
		return textSprite;
        return null;
	}
	
	/// create a text and add it to the screen
	function createText(text:String, font:String = "arial", ?align:TextAlign, ?wrap:Float):TextSprite {
		var textSprite:TextSprite = createText2(text, font, align, wrap);
		owner.addChild(new Entity().add(textSprite));
		return textSprite;
	}
	
	/// create a localized text
	function createText2L(id:String, ?align:TextAlign, ?wrap:Float):TextSprite {
		//var data = Translate.make(id);
		//var textSprite = createText2(data.text, data.font, align, wrap);
		//if (data.scale != 1) textSprite.setScale(data.scale);
		//textSprite.setXY(data.x, data.y);
		//return textSprite;
        return null;
	}
	
	/// create a localized text and add it to the screen
	function createTextL(id:String, ?align:TextAlign, ?wrap:Float):TextSprite {
		var textSprite = createText2L(id, align, wrap);
		owner.addChild(new Entity().add(textSprite));
		return textSprite;
	}
	
	function move(sprite:Sprite, x:Float, y:Float):Sprite {
		return sprite.setXY(sprite.x._ + x, sprite.y._ + y);
	}
	
	/// create a button and add it to the screen
	function createButton(onClick:PointerEvent -> Void, normal:String, ?hover:String):Button {
		var button:Button = createButton2(onClick, normal, hover);
		owner.addChild(button.owner);
		return button;
	}
	
	/// create a button
	function createButton2(onClick:PointerEvent -> Void, normal:String, ?hover:String):Button {
        var button:Button = new Button(resources.getTexture(normal), hover != null ? resources.getTexture(hover) : null);
        new Entity().add(button);
        button.setCallback(onClick);
        return button;
	}
    
    /// Creates a MuteButton and adds it to the screen.
    function createMuteButton(on:String, off:String):MuteButton {
        var button:MuteButton = new MuteButton(resources.getTexture(on), resources.getTexture(off));
        owner.addChild(new Entity().add(button));
        return button;
    }
    
    /**
     * Listens to a full-screen touch. Useful for views with no buttons.
     */
    function registerSystemTouch(onPointerDown:PointerEvent -> Void):Void {
        // if we are already holding the finger, skip this tap
		if (System.pointer.isDown()) {
			systemTouch = System.pointer.up.connect(onSysPointerUp);
		} else {
			systemTouch = System.pointer.down.connect(onSysPointerDown);
		}
        systemTouchCallback = onPointerDown;
    }
    
    function onSysPointerUp(e:PointerEvent):Void {
		systemTouch.dispose();
		systemTouch = System.pointer.down.connect(onSysPointerDown);
	}
    
    function onSysPointerDown(e:PointerEvent):Void {
		systemTouch.dispose();
		systemTouchCallback(e);
	}
    
    function center(sprite:Sprite, ?container:Sprite):Sprite {
        var containerWidth:Float, containerHeight:Float;
        if (container == null) {
            containerWidth = 750;
            containerHeight = 500;
        } else {
            containerWidth = container.getNaturalWidth();
            containerHeight = container.getNaturalHeight();
        }
        sprite.setXY((containerWidth - sprite.getNaturalWidth()) / 2, (containerHeight - sprite.getNaturalHeight()) / 2);
        return sprite;
    }
    
    
    /**
     * Creates the objects and allocate memory for rendering this view.
     * It doesn't show until we call activate().
     */
    public function show():Void {
        if (bground != null) owner.addChild(new Entity().add(new ImageSprite(bground)));
    }
    
    /**
     * Enables this view.
     * This is called after finishing the transition, if there is one. Otherwise
     * it is called immediately after show().
     */
    public function activate():Void {
        // override
    }
    
    /**
     * Disables this view. Good place to disconnect listeners.
     * This is called before starting the transition, if there is one. Otherwise
     * it is called immediately before hide().
     */
    public function deactivate():Void {
        // override
    }
    
    /**
     * Frees up all the resources used by this view.
     * The view can't be used again until we call init().
     */
    public function hide():Void {
        // override
    }
    
    /**
     * Frees up all the resources used by this view.
     * This will be automatically called right before unreferenciing this
     * object, which will mostly happen after hiding the view.
     */
    public function deinit():Void {
       // override 
    }
    
    /**
     * Updates the animations of this view.
     */
    public function update():Void {
        // override
    }
    
}