package core.ui.preloader;

import core.resource.Resources;
import core.ui.loader.LoaderModel;
import core.ui.View;

/**
 * This represents a view of the game.
 * @author Jorjon
 */
class PreloaderView extends View {
    
    var model:LoaderModel;

    public function new(resources:Resources, model:LoaderModel) {
        super(resources);
        this.model = model;
    }

}