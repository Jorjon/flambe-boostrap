package core.ui.preloader;

import core.Context;
import core.ui.Controller;
import core.ui.loader.LoaderModel;
import flambe.asset.AssetPack;

/**
 * This represents a state of the game.
 * @author Jorjon
 */
class PreloaderController extends Controller {
    
    var view:PreloaderView;
    var model:LoaderModel;

    public function new(context:Context, model:LoaderModel) {
        super(context);
        this.model = model;
    }

    override function setupView() {
        view = new PreloaderView(context.resources, model);
    }

    override public function activate():Void {
        showView(view);
        context.resources.loadManifest(model.manifest, onSuccess);
    }
    
    function onSuccess(pack:AssetPack) {
        context.states.goto(model.target);
    }

}