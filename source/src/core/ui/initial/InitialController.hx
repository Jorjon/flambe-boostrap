package core.ui.initial;

import core.Context;
import core.ui.Controller;

/**
 * This represents a state of the game.
 * @author Jorjon
 */
class InitialController extends Controller {
    
    var view:InitialView;

    @:keep public function new(context:Context) {
        super(context);
    }

    override function setupView() {
        view = new InitialView(context.resources);
        view.plane.setXY(50, 50);
    }

    override public function activate():Void {
        showView(view);
    }

}