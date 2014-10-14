package core.ui;

import flambe.Entity;
import flambe.scene.Director;
import flambe.scene.Transition;
import flambe.System;

/**
 * Basic screen flow system. It uses an implementation of MVC pattern.
 * @author Jorjon
 */
class StateManager {
    
    var context:Context;
    var director:Director;
    var currentController:Controller;
    var currentView:View;

    public function new(context:Context) {
        this.context = context;
        director = new Director();
        System.root.add(director);
    }
	
	public function goto(controller:Controller) {
        if (currentController != null) {
            currentController.deactivate();
        }
        currentController = controller;
        if (!currentController.inited) {
            currentController.inited = true;
            currentController.init();
            currentController.setupView();
        }
        currentController.activate();
	}
    
    /**
     * Shows a Scene containing a View.
     * Since there can only be one View active at any time, it deactivates the
     * previous View.
     * @param scene The entity holding the Scene component. Should also have
     * a child Entity containing a View.
     * @param transition
     */
    public function showView(scene:Entity, ?transition:Transition):Void {
        var view:View = scene.firstChild.get(View);
        if (currentView != null) {
            currentView.deactivate();
            currentView.deinit();
        }
        currentView = view;
        currentView.show();
        currentView.activate();
        director.unwindToScene(scene, transition);
    }
    
}