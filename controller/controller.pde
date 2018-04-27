///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose: A GUI designed to communicate with an Arduino from a computer through bluetooth to operate a rc car. //
// Author: Connor Grace                                                                                          //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


import processing.serial.*;    // Library for serial bluetooth communication
import controlP5.*;            // Library for the slider bar

ControlP5 cp5;
Slider speedSlider;

PImage left;      // Store left arrow image
PImage up;        // Store up arrow image
PImage right;     // Store right arrow image
PImage down;      // Store down arrow image
color fillL;
color fillU;
color fillR;
color fillD;
int[] keyLookup = {LEFT, UP, RIGHT, DOWN};
boolean[] dir = {false,false,false,false};    // Stores what arrow keys are currently pushed - LEFT, UP, RIGHT, DOWN
byte[] send = new byte[5];    // {Speed, Left, Forward, Right, Reverse} 

Serial myPort;  // Create object from Serial class

void setup() {
  // bluetooth
  printArray(Serial.list());                    // lists the bluetooth ports that are open  
  String portName = Serial.list()[2];           // change the value in the square brackets to bluetooth port number that is outgoing to the hc-05 module
  myPort = new Serial(this, portName, 9600);    // initialize myPort as a serial bluetooth connection to the hc-05 module        
  
  size(800,600);      // Set size of window to 800 x 600 px
  fillL = fillU = fillR = fillD = 255;
  background(#3D3D3B);
  
  left = loadImage("left.png");
  up = loadImage("up.png");
  right = loadImage("right.png");
  down = loadImage("down.png");
  
  cp5 = new ControlP5(this);
  
  // Create the speed slider
  // addSlider(theName, theMin, theMax, theDefaultValue, theX, theY, theW, theH)
  speedSlider = cp5.addSlider("%", 0,100, 0, width/4, 100, width/2, 30);
  speedSlider.setNumberOfTickMarks(21);
  speedSlider.setColorForeground(#CC1310);
  speedSlider.setColorActive(#CC1310);
  speedSlider.setColorBackground(#9EA39A);
  speedSlider.setColorValue(#000000);
}

void draw() {
  fill(#CC1310);
  textSize(42);
  textAlign(CENTER, CENTER);
  text("Speed", width/2, 50);
  
  // Draw arrow key boxes
  rectMode(CENTER);
  fill(fillL);
  rect((width/2)-125, height-150, 100, 100, 10);
  fill(fillU);
  rect(width/2, height-275, 100, 100, 10);
  fill(fillR);
  rect((width/2)+125, height-150, 100, 100, 10);
  fill(fillD);
  rect(width/2, height-150, 100, 100, 10);
  
  // Put arrow key images in their boxes
  imageMode(CENTER);
  image(left, (width/2)-125, height-150, 100, 100);
  image(up, width/2, height-275, 100, 100);
  image(right, (width/2)+125, height-150, 100, 100);
  image(down, width/2, height-150, 100, 100);
  
  updateDir();        // Call updateDir method
  
  // Send bluetooth message
  for (int i = 0; i < 5; i++){
    send[i] = 0;
  }
  
  send[0] = (byte)cp5.getController("%").getValue();    
  
  if (dir[0]) 
  {                          
    send[1] = 1;    
  }
  else 
  {
    send[1] = 0;
  }
  
  if (dir[1]) 
  {                           
    send[2] = 1;        
  }
  else 
  {  
    send[2] = 0;
  }
  
  if (dir[2]) 
  {                          
    send[3] = 1;        
  }
  else 
  {                          
    send[3] = 0;       
  }
  
  if (dir[3]) 
  {                          
    send[4] = 1;       
  }
  else 
  {                          
    send[4] = 0;      
  }
  
  myPort.write(send);    // send data through bluetooth
}

// Method to fill in the arrow key boxes red if they are currently pressed
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

// Method to update boolean array dir if a key is pressed or not
void keys(boolean pressed){
   for (int i = 0; i < keyLookup.length; i++){
     if (keyCode == keyLookup[i])
       dir[i] = pressed;
   }
}