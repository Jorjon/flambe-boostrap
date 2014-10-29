package core.audio;

import core.resource.Resources;
import flambe.animation.AnimatedFloat;
import flambe.sound.Playback;
import flambe.sound.Sound;
import flambe.System;

/**
 * ...
 * @author Jorjon
 */

class Audio {
    static private var intervalFrames:Float = 0;
    static public var volume(get, null):AnimatedFloat;
    static private var channels:Map<AudioChannel, Playback> = new Map<AudioChannel, Playback>();
    static public var resources:Resources;

    /**
     * Play a sound.
     * @param id Id of the asset
     * @param volume The playback volume between 0 (silence) and 1 (full volume). Defaults to 1.
     * @param loop Loop forever?
     * @param channel The channel (layer) in which to play this sound. No two sounds can play at the same time on the same channel.
     * @param weak If true, it there's already a sound on that channel it won't play. If false, if there's already
     *             a sound on that channel it will stop the previous and play this one.
     */
	static public function play(id:String, ?channel:AudioChannel, volume:Float = 1, loop:Bool = false, weak:Bool = false):Playback {
        var sfx:Sound = resources.getSound(id);
        if (sfx.duration <= 0) return null;
        
        if (channel == null) channel = OTHER;
        // there's something on that channel, maybe a playing sound or a finished sound
        if (channels.exists(channel)) {
            var playback:Playback = channels.get(channel);
            // there's no sound playing on that channel, play freely
            if (playback == null || playback.complete._) {
                return __playSoundInChannel(sfx, volume, loop, channel, playback);
            // there's already a playing sound in that channel, check weak condition
            } else {
                if (weak) {
                    return null;
                } else {
                    return __playSoundInChannel(sfx, volume, loop, channel, playback);
                }
            }
        // there's nothing on that channel, play freely
        } else {
            return __playSoundInChannel(sfx, volume, loop, channel);
        }
    }

    /* 
     Clear playbacks after a new AssetPack is loaded to prevent Playback with disposed Sounds to be touched:
     https://groups.google.com/forum/#!topic/flambe/7oSOA1qyIeY
    */
    static public function clearPlaybacks()
    {
       channels.set(BALLS, null);
       //channels.set(POWERUPS, null);
       //channels.set(OTHER, null);
       //channels.set(CROWD, null);
    }
    
    static private function __playSoundInChannel(sound:Sound, volume:Float, loop:Bool, channel:AudioChannel, ?oldPlayback:Playback):Playback {
        if (oldPlayback != null) {
            oldPlayback.paused = true;
            oldPlayback.dispose();
            channels.set(channel, null);
        }
        oldPlayback = loop ? sound.loop(volume) : sound.play(volume);
        channels.set(channel, oldPlayback);
        return oldPlayback;
    }
    
    static public function isPlaying(?channel:AudioChannel):Bool {
        if (channel != null) {
            return channels.exists(channel) && channels.get(channel) != null && !channels.get(channel).complete._;
        } else {
            for (i in channels) {
                if (i != null && !i.complete._) return true;
            } return false;
        }
    }
    
    static public function playMusic(id:String):Playback {
        return play(id, MUSIC, 1, true, false);
    }
    
    /**
     * Plays the sound in a certain interval, useful to play steps sounds.
     * There can only be one intervaled sound at a time.
     * It should be called every frame when the sound is needed in order to update the timer.
     * @param id
     * @param frames
     */
    static public function playInverval(id:String, frames:Float, ?channel:AudioChannel) {
        if (intervalFrames == 0) {
            intervalFrames = frames;
            play(id, channel);
        } else {
            intervalFrames--;
        }
        
    }
    
    static private function get_volume():AnimatedFloat {
        return System.volume;
    }
    
}