package core;
import core.audio.Audio;
//import core.html.AutoScale;
import core.resource.Resources;
import core.resource.SelectiveManifest;
import core.ui.Controller;
import core.ui.loader.LoaderController;
import core.ui.loader.LoaderModel;
import core.ui.preloader.PreloaderController;
import core.ui.StateManager;
import flambe.asset.Manifest;
//import flambe.display.Sprite;
import flambe.System;

/**
 * ...
 * @author Jorjon
 */
class Flambe{

    static public function start(startController:Class<Controller>, startPackages:Array<String>):Void {
        
        // Wind up all platform-specific stuff.
        System.init();

        // Add AutoScale
        //#if js
        //System.root.add(new Sprite());
        //System.root.add(new AutoScale());
        //#end
        
        // Create managers.
        var context = new Context();
        context.states = new StateManager(context);
        context.resources = new Resources(context);
        Audio.resources = context.resources;
        
        // Initial packages to be loaded.
        var initialManifest:SelectiveManifest = new SelectiveManifest();
        initialManifest.addPacks(startPackages);
        
        // The preloader loads the loader, and the loader loads the inital packages listed above.
        context.states.goto(
            new PreloaderController(
                context, new LoaderModel(Manifest.fromAssets("loader"),
                    new LoaderController(
                        context, new LoaderModel(initialManifest,
                            Type.createInstance(startController, [context])
                        )
                    )
                )
            )
        );
    }
    
}