package;

import haxe.Timer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.*;
import openfl.ui.Keyboard;

import ui.Console;

class Main extends Sprite {
  var console: Console;
  var fps: FPS;
  var prev_time: Int;

  public function new() {
    super();
    console = new Console();
    console.update(0);

    #if js
      haxe.Log.trace = function(v: Dynamic, ?i):Void {
        var msg = if (i != null) i.fileName + ":" + i.lineNumber + ": " + v else v;
        console.log(msg);
        untyped __js__("console").log(msg);
      }
    #else
      haxe.Log.trace = function(v: Dynamic, ?i):Void {
        var msg = if (i != null) i.fileName + ":" + i.lineNumber + ": " + v else v;
        console.log(msg);
      }
    #end

    init();
  }

  public function init() {
    KeyInput.initialize();
    prev_time = lime.system.System.getTimer();

    var bitmap = new Bitmap(Assets.getBitmapData("assets/openfl.png"));
    bitmap.x = (stage.stageWidth - bitmap.width) / 2;
    bitmap.y = (stage.stageHeight - bitmap.height) / 2;
    addChild(bitmap);

    fps = new FPS();
    addChild(fps);

    addChild(console);

    stage.addEventListener(KeyboardEvent.KEY_DOWN, Key_Down);
    stage.addEventListener(KeyboardEvent.KEY_UP, Key_Up);
    stage.addEventListener(Event.ENTER_FRAME, Update);
  }

  private function Key_Down(event: KeyboardEvent):Void {
    if (!KeyInput.keys[event.keyCode] && event.keyCode == Keyboard.BACKQUOTE) {
      console.visible = !console.visible;
    }
    
    KeyInput.keys[event.keyCode] = true;
  }

  private function Key_Up(event: KeyboardEvent):Void {
    KeyInput.keys[event.keyCode] = false;
  }

  private function Update(event: Event):Void {
    var current_time = lime.system.System.getTimer();
    var delta = (current_time - prev_time) / 1000.0;
    prev_time = current_time;

    var speed = 50;

    console.update(delta);
  }
}