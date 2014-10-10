package core.ui.loader ;

import core.resource.Resources;
import core.ui.loader.LoaderModel;
import core.ui.View;
import flambe.display.FillSprite;

/**
 * ...
 * @author Jorjon
 */
class LoaderView extends View {

    var barfill:FillSprite;
    var model:LoaderModel;
    
    public function new(resources:Resources, model:LoaderModel) {
        super(resources);
        this.model = model;
    }
    
    override public function show():Void {
        barfill = new FillSprite(0xFFFFFF, 100, 50);
        addSprite(barfill);
    }
    
    override public function update():Void {
        //barfill.scissor.width = model.progress / model.total * barfill.getNaturalWidth();
    }
    
}