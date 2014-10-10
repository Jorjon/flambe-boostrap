package core.ui;

/**
 * @author Jorjon
 */

interface IState {
    public function init():Void;
    public function activate():Void;
    public function deactivate():Void;
    public function deinit():Void;
}