package urgame.screens.widgets;

import core.Audio;
import flambe.display.ImageSprite;
import flambe.Entity;
import flambe.input.PointerEvent;

/**
 * ...
 * @author Jorjon
 */
class MuteButton extends Button{

    private var imageOn:ImageSprite;
    private var imageOff:ImageSprite;
    private var entity:Entity;
    
    public function new(assetOn:String, assetOff:String) {
        entity = new Entity();
        imageOn = new ImageSprite(Main.getTexture(assetOn));
        imageOff = new ImageSprite(Main.getTexture(assetOff));
        if (Audio.isPlaying() && Audio.volume._ > 0) {
            entity.add(imageOn);
        } else {
            entity.add(imageOff);
        }
        if (owner != null) {
            onAdded();
        }
        super();
    }
    
    override private function onDown(e:PointerEvent):Bool {
        if (!super.onDown(e)) return false;
        
        if (imageOn.owner == null) {
            Audio.volume.animateTo(1, .2);
            entity.add(imageOn);
        } else if (imageOff.owner == null) {
            Audio.volume.animateTo(0, .2);
            entity.add(imageOff);
        }
        return true;
    }
    
    override public function onAdded() {
        super.onAdded();
        owner.addChild(entity);
    }
    
}