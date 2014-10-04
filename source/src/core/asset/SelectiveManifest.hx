package core.asset;
import flambe.asset.Manifest;
import haxe.rtti.Meta;
using flambe.util.Strings;

/**
 * ...
 * @author Jorjon
 */
class SelectiveManifest extends Manifest{

    public function new() {
        super();
        localBase = "assets";
    }
    
    /**
     * Gets the manifest of a pack in the asset directory, that was processed at build-time.
     * @param packName The folder name in your assets/ directory.
     * @param required When true and this pack was not found, throw an error. Otherwise null is
     *   returned.
     */
    public function addPacks(packNames:Array<String>, required:Bool = true):SelectiveManifest {
		for (packName in packNames) {
			addPack(packName, required);
		}
        return this;
    }
    
    /**
     * Gets the manifest of a pack in the asset directory, that was processed at build-time.
     * @param packName The folder name in your assets/ directory.
     * @param required When true and this pack was not found, throw an error. Otherwise null is
     *   returned.
     */
    public function addPack(packName :String, required :Bool = true):SelectiveManifest{
        var packData :Array<Dynamic> = Reflect.field(Meta.getType(Manifest).assets[0], packName);
        if (packData == null) {
            if (required) {
                throw "Missing asset pack".withFields(["name", packName]);
            }
            return null;
        }
        for (asset in packData) {
            var name = asset.name;
            var path = packName + "/" + name + "?v=" + asset.md5;
            var format = Manifest.inferFormat(name);
            if (format != Data) {
                name = name.removeFileExtension();
            }
            add(name, path, asset.bytes, format);
        }
        return this;
    }
    
    public function addFiles(files:Array<String>):SelectiveManifest {
        var assets:Dynamic = Reflect.field(Meta.getType(Manifest), "assets")[0];
        
        // flatten the files
        var packages:Array<String> = Reflect.fields(assets);
        var paths:Map<String, Dynamic> = new Map<String, String>();
        var packageFiles:Array<Dynamic>;
        for (packageName in packages) {
            packageFiles = cast Reflect.field(assets, packageName);
            for (asset in packageFiles) {
                var barePath:String = Strings.removeFileExtension(asset.name);
                if (barePath.indexOf("/") != -1) {
                    barePath = barePath.substr(barePath.lastIndexOf("/") + 1);
                }
                paths[barePath] = { url: packageName + "/" + asset.name + "?v=" + asset.md5, bytes: asset.bytes };
            }
        }
        
        // search in flattened files
        for (i in files) {
            if (!paths.exists(i)) {
                throw "Missing asset".withFields(["name", i]);
                return null;
            }
            add(i, paths[i].url, paths[i].bytes);
        }
        return this;
    }
    
}