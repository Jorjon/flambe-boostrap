package core.ui;
import core.resource.Resources;
import core.ui.widget.Button;
import flambe.display.Font.TextAlign;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.display.TextSprite;
import flambe.display.Texture;
import flambe.Entity;
import flambe.input.PointerEvent;

/**
 * ...
 * @author Jorjon
 */
class View extends Sprite {

    public var inited:Bool;
    public var opaque:Bool = true;
	var bground:Texture;
    var resources:Resources;

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
		//var textSprite:TextSprite = cast new TextSprite(new Font(Main.mainPack, font), text).disablePointer();
		//if (align != null) textSprite.align = align;
		//if (wrap != null) textSprite.wrapWidth._ = wrap;
		//owner.addChild(new Entity().add(textSprite));
		//return textSprite;
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
	function createButton(onClick:PointerEvent -> Void, asset:String):Button {
		var button:Button = createButton2(onClick, asset);
		owner.addChild(button.owner);
		return button;
	}
	
	/// create a button
	function createButton2(onClick:PointerEvent -> Void, asset:String):Button {
        var containerButton:Button = new Button();
        new Entity().add(containerButton);
        containerButton.setCallback(onClick);
        containerButton.owner.addChild(new Entity().add(new ImageSprite(resources.getTexture(asset))));
        return containerButton;
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