package core.ui;
import flambe.Entity;
import flambe.scene.Director;
import flambe.scene.Transition;
import flambe.System;

/**
 * ...
 * @author Jorjon
 */
class StateManager {
    
    var context:Context;
    var director:Director;
    var current:Controller;

    public function new(context:Context) {
        this.context = context;
        director = new Director();
        System.root.add(director);
    }
	
	public function goto(controller:Controller) {
        if (current != null) {
            current.deactivate();
        }
        current = controller;
        if (!current.inited) {
            current.inited = true;
            current.init();
            current.setupView();
        }
        trace(current + " activate");
        current.activate();
	}
    
    public function showView(scene:Entity, ?transition:Transition):Void {
        director.unwindToScene(scene, transition);
    }
    
}