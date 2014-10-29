package core.ui.initial;

import core.resource.Resources;
import core.ui.View;
import flambe.display.ImageSprite;

/**
 * This represents a view of the game.
 * @author Jorjon
 */
class InitialView extends View {

    public var plane:ImageSprite;
    
    public function new(resources:Resources) {
        super(resources);
        plane = new ImageSprite(resources.getTexture("plane"));
    }

    override public function show():Void {
        super.show();
        // create widgets here
        addSprite(plane);
    }
    
}