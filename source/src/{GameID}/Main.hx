package {GameID};

import core.Context;
import core.resource.Resources;
import core.resource.SelectiveManifest;
import core.ui.loader.LoaderController;
import core.ui.loader.LoaderModel;
import core.ui.preloader.PreloaderController;
import core.ui.StateManager;
import flambe.asset.Manifest;
import flambe.System;

class Main {
    
    static var context:Context;
    
    static function main () {
        
        // Wind up all platform-specific stuff.
        System.init();
        
        // Create managers.
        context = new Context();
        context.states = new StateManager(context);
        context.resources = new Resources(context);
        
        // Initial packages to be loaded.
        var initialManifest:SelectiveManifest = new SelectiveManifest();
        initialManifest.addPacks(["initial"]);
        
        // The preloader loads the loader, and the loader loads the inital packages listed above.
        context.states.goto(
            new PreloaderController(
                context, new LoaderModel(Manifest.fromAssets("loader"),
                    new LoaderController(
                        context, new LoaderModel(initialManifest,
                            new InitialController(context)
                        )
                    )
                )
            )
        );
    }
}
