// Bluetooth?
//   BtSerial, bluetoothDesktop

import controlP5.*;
import bluetoothDesktop.*;

ControlP5 cp5;
Slider speedSlider;
PImage left;
PImage up;
PImage right;
PImage down;
color fillL;
color fillU;
color fillR;
color fillD;
int[] keyLookup = {LEFT, UP, RIGHT, DOWN};
boolean[] dir = {false,false,false,false};

// Setup bluetooth connection
Bluetooth bt;
String statusMsg = "inactive";
Service[] services = new Service[0];
Device[] devices = new Device[0];
Client[] clients = new Client[0];

void setup() {
  size(800,600);
  fillL = fillU = fillR = fillD = 255;
  background(#3D3D3B);
  
  left = loadImage("left.png");
  up = loadImage("up.png");
  right = loadImage("right.png");
  down = loadImage("down.png");
  
  cp5 = new ControlP5(this);
  
  // addSlider(theName, theMin, theMax, theDefaultValue, theX, theY, theW, theH)
  speedSlider = cp5.addSlider("%", 0,100, 0, width/4, 100, width/2, 30);
  speedSlider.setNumberOfTickMarks(21);
  speedSlider.setColorForeground(#CC1310);
  speedSlider.setColorActive(#CC1310);
  speedSlider.setColorBackground(#9EA39A);
  speedSlider.setColorValue(#000000);
  
  // bluetooth
  try {
    bt = new Bluetooth(this, 0x0003); // RFCOMM
    
    // Start a Service
    bt.start("simpleService");
    bt.find();
    statusMsg = "starting search";
  }
  catch (RuntimeException e) {
    statusMsg = "bluetooth off?";
    println(e);
  }
}

void draw() {
  fill(#CC1310);
  textSize(42);
  textAlign(CENTER, CENTER);
  text("Speed", width/2, 50);
  
  rectMode(CENTER);
  fill(fillL);
  rect((width/2)-125, height-150, 100, 100, 10);
  fill(fillU);
  rect(width/2, height-275, 100, 100, 10);
  fill(fillR);
  rect((width/2)+125, height-150, 100, 100, 10);
  fill(fillD);
  rect(width/2, height-150, 100, 100, 10);
  
  imageMode(CENTER);
  image(left, (width/2)-125, height-150, 100, 100);
  image(up, width/2, height-275, 100, 100);
  image(right, (width/2)+125, height-150, 100, 100);
  image(down, width/2, height-150, 100, 100);
  updateDir();
  
  // bluetooth
  
}

void updateDir() {
  if (dir[0])
    fillL = #FF5D4E;
  else
    fillL = 255;
  if (dir[1])
    fillU = #FF5D4E;
  else
    fillU = 255;
  if (dir[2])
    fillR = #FF5D4E;
  else
    fillR = 255;
  if (dir[3])
    fillD = #FF5D4E;
  else
    fillD = 255;
}

void keyPressed(){
  keys(true);
}

void keyReleased(){
  keys(false);
}

void keys(boolean pressed){
   for (int i = 0; i < keyLookup.length; i++){
     if (keyCode == keyLookup[i])
       dir[i] = pressed;
   }
}