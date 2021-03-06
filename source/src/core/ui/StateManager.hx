package core.ui;

import flambe.Entity;
import flambe.scene.Director;
import flambe.scene.Transition;
import flambe.System;

/**
 * Basic screen flow system. It uses an implementation of MVC pattern.
 * @author Jorjon
 */
class StateManager extends Director {
    
    var context:Context;
    var currentController:Controller;
    var currentView:View;

    public function new(context:Context) {
        super();
        this.context = context;
        System.root.add(this);
    }
    
    override public function onUpdate(dt:Float) {
        super.onUpdate(dt);
        currentController.update(dt);
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
        unwindToScene(scene, transition);
    }
    
}