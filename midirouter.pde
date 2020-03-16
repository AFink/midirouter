import controlP5.*;
import themidibus.*;
import java.util.*;

ControlP5 cp5;
MidiBus in;
MidiBus out;

boolean generalswitch = false;

List<String> li = new ArrayList<String>();
List<String> lo = new ArrayList<String>();


void setup() {
  size(800,700);

  PFont font = createFont("arial", 20);

  cp5 = new ControlP5(this);

  in = new MidiBus(this,-1,-1,"in");
  out = new MidiBus(this,-1,-1,"out");

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



  for (int i = 0; i<in.availableInputs().length; i++) {
    li.add(in.availableInputs()[i]);
  }


  for (int i = 0; i<in.availableOutputs().length; i++) {
    lo.add(in.availableOutputs()[i]);
  }

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("input1")
    .setPosition(250, 0)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setItems(li)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;


  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("output1")
    .setPosition(450, 0)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setItems(lo)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

cp5.addScrollableList("input2")
    .setPosition(250, 500)
    .setSize(200, 100)
    .setBarHeight(20)
    .setItemHeight(20)
    .setItems(li)
    // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
    ;

  /* add a ScrollableList, by default it behaves like a DropdownList */
  cp5.addScrollableList("output2")
    .setPosition(450, 500)
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



void noteOn(int channel, int pitch, int velocity, long timestamp, String bus_name) {
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  println("Timestamp:"+timestamp);
  println("Recieved on Bus:"+bus_name);
  if (bus_name == "in") {
    out.sendNoteOn(channel, pitch, velocity);
  } else if (bus_name == "out") {
    in.sendNoteOn(channel, pitch, velocity);
  }
}

void noteOff(int channel, int pitch, int velocity, long timestamp, String bus_name) {
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
  println("Timestamp:"+timestamp);
  println("Recieved on Bus:"+bus_name);
  if (bus_name == "in") {
    out.sendNoteOff(channel, pitch, velocity);
  } else if (bus_name == "out") {
    in.sendNoteOff(channel, pitch, velocity);
  }
}

void controllerChange(int channel, int number, int value, long timestamp, String bus_name) {
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  println("Timestamp:"+timestamp);
  println("Recieved on Bus:"+bus_name);
  if (bus_name == "in") {
    out.sendControllerChange(channel, number, value);
  } else if (bus_name == "out") {
    in.sendControllerChange(channel, number, value);
  }
}





void input1(int n) {
   in.clearInputs();
   in.addInput(n);
   
}

void input2(int n) {
   out.clearInputs();
   out.addInput(n);

}void output1(int n) {
   in.clearOutputs();
   in.addOutput(n);
}
void output2(int n) {
out.clearOutputs();
   out.addOutput(n);
}
