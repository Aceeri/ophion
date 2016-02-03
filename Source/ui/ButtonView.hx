package;

import openfl.display.Shape;
import openfl.display.Texture;
import openfl.geom.Matrix;

public class ButtonView extends Shape {
  enum State {
    unhighlight:Int = 0;
    highlight  :Int = 1;
    clicked    :Int = 2;
  }
  private var state       : State;
  private static colour : Vector<Int>,
                 shapes : Vector<Shape>;

  public function new(width:int, height:int) {
    // -- static inits --
    if ( colour == null ) {
      colour = [0x5A607A, 0x506030, 0x500000];
    }
    // -- constructor --
    setState(State.unhighlight);
  };


  public function setState(s:State) : Void {
    state = s;

    graphics.clear();
    graphics.beginFill( colour[int(s)] );
    graphics.drawRect(0, 0, width, height);
    graphics.endFill();
  }
  public function retState() : State { return state; }
};