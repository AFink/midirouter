import controlP5.*;
import themidibus.*;
import java.util.*;

ControlP5 cp5;
MidiBus meinebusse[];


boolean generalswitch = false;

List<String> li = new ArrayList<String>();
List<String> lo = new ArrayList<String>();


void setup() {
  size(700, 400);

  PFont font = createFont("arial", 20);

  cp5 = new ControlP5(this);

  meinebusse = new MidiBus[100];

  for(int i = 0; i < 100; i ++){
    meinebusse[i] = new MidiBus(this, -1, -1); 
  }

  MidiBus.list(); 

  cp5.addButton("control")
    .setPosition(0, 0)
    .setSize(200, 40)
    .setValue(0)
    .addCallback(new CallbackListener() {
    public void controlEvent(CallbackEvent event) {
      if (event.getAction() == ControlP5.ACTION_RELEASED) {
        if (generalswitch == false) {
          generalswitch = true;
          cp5.getController("control").setColorBackground(#00FF00);
          cp5.getController("control").setColorForeground(#00FF00);
        } else {
          generalswitch = false;
          cp5.getController("control").setColorBackground(#FF0000);
          cp5.getController("control").setColorForeground(#FF0000);
        }
        println("new control stage: " + generalswitch);
      }
    }
  }
  )
  ;



  for (int i = 0; i<meinebusse[0].availableInputs().length; i++) {
    li.add(meinebusse[0].availableInputs()[i]);
  }

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("inputs")
    .setPosition(250, 0)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setItems(li)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;


  for (int i = 0; i<10; i++) {
    lo.add(meinebusse[0].availableOutputs()[i]);
  }
  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("outputs")
    .setPosition(450, 0)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setItems(lo)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  textFont(font);
}

void draw() {
  background(0);
}



void rawMidi(byte[] data) { 
  if (generalswitch == true) {
  } else {
  }
}






void inputs(int n) {
 
}

void outputs(int n) {

}
