package core.ui.loader ;

import core.Context;
import core.ui.Controller;
import core.ui.loader.LoaderView;
import flambe.asset.AssetPack;

/**
 * ...
 * @author Jorjon
 */
class LoaderController extends Controller {
    
    var view:LoaderView;
    var model:LoaderModel;

    public function new(context:Context, model:LoaderModel) {
        super(context);
        this.model = model;
    }
    
    override function setupView() {
        view = new LoaderView(context.resources, model);
    }
    
    override public function activate():Void {
        showView(view);
        context.resources.loadManifest(model.manifest, onSuccess);
    }
    
    function onSuccess(pack:AssetPack) {
        context.states.goto(model.target);
    }
    
}