package core;
import flambe.animation.AnimatedFloat;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.display.TextSprite;
import flambe.display.Texture;
import flambe.Entity;
import flambe.input.PointerEvent;
import flambe.math.Rectangle;
import flambe.scene.Scene;
import flambe.sound.Playback;
import flambe.System;
import urgame.Main;
import urgame.screens.widgets.Button;
import urgame.screens.widgets.ButtonOrthogonal;

/**
 * ...
 * @author Jorjon
 */
class Screen extends Scene{

	private var bground:Texture;
	
	public function new(background:String=null, opaque:Bool = true) {
		super(opaque);
		if (background != null) {
            bground = Main.getTexture(background);
        }
	}
    
	override public function onAdded():Void {
		if (bground != null) owner.addChild(new Entity().add(new ImageSprite(bground)));
		setupScreen();
		setupWidgets();
	}
	
	private function setupScreen():Void {
		// override
	}
	
	/// create an image and add it to the screen
	private function createImage(asset:String, append:Bool = true):ImageSprite {
		var sprite = createImage2(asset);
		owner.addChild(new Entity().add(sprite), append);
		return sprite;
	}
    
    /// Add a sprite to the screen
    private function addSprite(sprite:Sprite, append:Bool = true):Sprite {
        owner.addChild(new Entity().add(sprite), append);
        return sprite;
    }
    
	/// create an image
	private function createImage2(asset:String):ImageSprite {
		return cast new ImageSprite(asset == "" ? null : Main.getTexture(asset)).disablePointer();
	}
	
	/// create a text
	private function createText2(text:String, font:String = "arial", ?align:TextAlign, ?wrap:Float):TextSprite {
		var textSprite:TextSprite = cast new TextSprite(new Font(Main.mainPack, font), text).disablePointer();
		if (align != null) textSprite.align = align;
		if (wrap != null) textSprite.wrapWidth._ = wrap;
		owner.addChild(new Entity().add(textSprite));
		return textSprite;
	}
	
	/// create a text and add it to the screen
	private function createText(text:String, font:String = "arial", ?align:TextAlign, ?wrap:Float):TextSprite {
		var textSprite:TextSprite = createText2(text, font, align, wrap);
		owner.addChild(new Entity().add(textSprite));
		return textSprite;
	}
	
	/// create a localized text
	private function createText2L(id:String, ?align:TextAlign, ?wrap:Float):TextSprite {
		var data = Translate.make(id);
		var textSprite = createText2(data.text, data.font, align, wrap);
		if (data.scale != 1) textSprite.setScale(data.scale);
		textSprite.setXY(data.x, data.y);
		return textSprite;
	}
	
	/// create a localized text and add it to the screen
	private function createTextL(id:String, ?align:TextAlign, ?wrap:Float):TextSprite {
		var textSprite = createText2L(id, align, wrap);
		owner.addChild(new Entity().add(textSprite));
		return textSprite;
	}
	
	private function move(sprite:Sprite, x:Float, y:Float):Sprite {
		return sprite.setXY(sprite.x._ + x, sprite.y._ + y);
	}
	
	/// create a button and add it to the screen
	private function createButton(onClick:PointerEvent -> Void, asset:String):Button {
		var button:Button = createButton2(onClick, asset);
		owner.addChild(button.owner);
		return button;
	}
	
	/// create a button
	private function createButton2(onClick:PointerEvent -> Void, asset:String):Button {
        var containerButton:Button = new Button();
        new Entity().add(containerButton);
        containerButton.setCallback(onClick);
        containerButton.owner.addChild(new Entity().add(new ImageSprite(Main.getTexture(asset))));
        return containerButton;
	}

		/// create a orthogonal button and add it to the screen
	private function createButtonOrthogonal(onClick:PointerEvent -> Void, asset:String, assetHeight: Int):Button {
		var button:Button = createButtonOrthogonal2(onClick, asset, assetHeight);
		owner.addChild(button.owner);
		return button;
	}
	
		/// create a orthogonal button 
	private function createButtonOrthogonal2(onClick:PointerEvent -> Void,asset:String, assetHeight: Int):Button {
        var containerButton:Button = new ButtonOrthogonal(assetHeight);
        new Entity().add(containerButton);
        containerButton.setCallback(onClick);
        containerButton.owner.addChild(new Entity().add(new ImageSprite(Main.getTexture(asset))));
        return containerButton;
	}
	
	private function setupWidgets():Void {
		// override
	}
	
	private function centerWidget(widget:Sprite, horizontal:Bool = true, vertical:Bool = true):Void {
		if (horizontal) widget.x._ = widget.x._ + (960 - widget.getNaturalWidth()) / 2;
		if (vertical) widget.y._ = widget.y._ + (480 - widget.getNaturalHeight()) / 2;
	}
	
	private function showScreen(screen:Dynamic, transition:String = "left"):Void {
		var scene:Entity = Std.is(screen, Entity) ? screen : new Entity().add(screen);
		Main.show(scene, transition);
	}
	
	public function onShow():Void {
		// override
	}
	
	private function changeScreen(screen:Dynamic, transition:String = "left"):Void {
		var scene:Entity = Std.is(screen, Entity) ? screen : new Entity().add(screen);
		Main.goto(scene, transition);
		scene.get(Screen).onShow();
	}
	
}