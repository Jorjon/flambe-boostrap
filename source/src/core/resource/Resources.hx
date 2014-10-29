package core.resource;
import flambe.asset.AssetPack;
import flambe.asset.File;
import flambe.asset.Manifest;
import flambe.display.Texture;
import flambe.sound.Sound;
import flambe.System;
import flambe.util.Disposable;
import flambe.util.Promise;

/**
 * ...
 * @author Jorjon
 */
class Resources{
    
    var context:Context;
    var loadedPackages:Array<AssetPack>;

    public function new(context:Context) {
        this.context = context;
        loadedPackages = new Array<AssetPack>();
    }
    
    public function loadManifest(manifest:Manifest, ?onComplete:AssetPack -> Void, ?onProgress:Void -> Void):Promise<AssetPack> {
        var promise:Promise<AssetPack> = System.loadAssetPack(manifest);
        promise.get(function (pack:AssetPack) { loadedPackages.push(pack); if (onComplete != null) onComplete(pack); } );
        if (onProgress != null) promise.progressChanged.connect(onProgress);
        return promise;
    }
    
    public function loadFolder(name:String, ?onComplete:AssetPack -> Void, ?onProgress:Void -> Void):Promise<AssetPack> {
        return loadManifest(Manifest.fromAssets(name), onComplete, onProgress);
    }
    
    public function getTexture(name:String, required:Bool = true):Texture {
        var asset;
        for (i in 0...loadedPackages.length) {
            asset = loadedPackages[i].getTexture(name, (i == loadedPackages.length - 1) ? required : false);
            if (asset != null) return asset;
        }
        return null;
    }
    
    /**
     * Finds the AssetPack containing the given File.
     * @param name
     * @return The AssetPack containing the given File.
     */
    public function findFile(name:String):AssetPack {
        var asset;
        for (i in 0...loadedPackages.length) {
            asset = loadedPackages[i].getFile(name, false);
            if (asset != null) return loadedPackages[i];
        } return null;
    }
    
    public function getFile(name:String, required:Bool = true):File {
        var asset;
        for (i in 0...loadedPackages.length) {
            asset = loadedPackages[i].getFile(name, (i == loadedPackages.length - 1) ? required : false);
            if (asset != null) return asset;
        }
        return null;
    }
    
    public function getSound(name:String, required:Bool = true):Sound {
        var asset;
        for (i in 0...loadedPackages.length) {
            asset = loadedPackages[i].getSound(name, (i == loadedPackages.length - 1) ? required : false);
            if (asset != null) return asset;
        }
        return null;
    }
    
}