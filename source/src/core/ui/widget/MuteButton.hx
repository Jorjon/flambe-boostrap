package core.ui.widget;

import core.audio.Audio;
import core.ui.widget.Button;
import flambe.display.Texture;
import flambe.input.PointerEvent;

/**
 * ...
 * @author Jorjon
 */
class MuteButton extends Button{
    var assetOn:Texture;
    var assetOff:Texture;

    public function new(assetOn:Texture, assetOff:Texture) {
        this.assetOff = assetOff;
        this.assetOn = assetOn;
        if (Audio.isPlaying() && Audio.volume._ > 0) {
            super(assetOn);
        } else {
            super(assetOff);
        }
    }
    
    override private function onDown(e:PointerEvent):Bool {
        if (!super.onDown(e)) return false;
        
        if (texture == assetOff) {
            Audio.volume.animateTo(1, .2);
            texture = assetOn;
        } else if (texture == assetOn) {
            Audio.volume.animateTo(0, .2);
            texture = assetOff;
        }
        return true;
    }
    
    override function onOut(e:PointerEvent):Bool {
        if (origin == null) return false;
        y.animateTo(origin.y - 2, .1);
        return true;
    }
    
}