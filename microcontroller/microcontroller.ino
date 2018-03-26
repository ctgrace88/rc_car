////////////////////////////////////////////////////////////////////////////
// Purpose: Arduino code used to control the motor and servo on an rc car //
// Authors: Connor Grace, Emily Sior                                      //
////////////////////////////////////////////////////////////////////////////

#include <Servo.h>

byte state[] = {0,0,0,0,0};   // store inputs from GUI controller
int stateLoop = 0;            // iterater for state array
int AIN1 = 15;                // setup motor pins
int AIN2 = 16;
int motor_voltage = 0;        // intially set motor voltage to 0 to turn motors off. --we will need a way to adjust this for the speed
Servo testServo;              // create test servo
int servoPIN = 7;             // create pin for servo
int degree_right = 0;
int degree_left = 70;         // ?? probably need to adjust these angles
int degree_straight = 35;
//int ledPin = 13;
//int left = 7;
//int forward = 6;
//int right = 5;
//int reverse = 4;

void setup() {
//  pinMode(ledPin, OUTPUT); 
//  pinMode(left, OUTPUT);
//  pinMode(forward, OUTPUT);
//  pinMode(right, OUTPUT);
//  pinMode(reverse, OUTPUT);
  pinMode(ledPin, OUTPUT); 
  pinMode(servoPIN, OUTPUT);    
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  Serial.begin(9600);          // Start serial communication at 9600 bps
}

void loop() {
  stateLoop = 0;
  while (stateLoop <= 4) {
    if (Serial.available()) {
      state[stateLoop] = Serial.read();
      stateLoop++;
    }
  }

  motor_voltage = (2*state[0]);    // set motor speed (0V - 200V)
  
  if (state[1] == 1) {
    testServo.write(degree_left);
    //digitalWrite(left, HIGH);
  }
  else {
    testServo.write(degree_straight);
    //digitalWrite(left, LOW);
  }
  
  
  if (state[2] == 1) {
    digitalWrite(AIN2, LOW);    
    analogWrite(AIN1, motor_voltage);
    //digitalWrite(forward, HIGH);
  }
  else {
    digitalWrite(AIN2, LOW);
    digitalWrite(AIN1, LOW);
    //digitalWrite(forward, LOW);
  }
  
  
  if (state[3] == 1) {
    testServo.write(degree_right);
    //digitalWrite(right, HIGH);
  }
  else {
    testServo.write(degree_straight);
    //digitalWrite(right, LOW);
  }
  
  
  if (state[4] == 1) {
    digitalWrite(AIN1, LOW);    
    analogWrite(AIN2, motor_voltage);
    //digitalWrite(reverse, HIGH);
  }
  else {
    digitalWrite(AIN1, LOW);
    digitalWrite(AIN2, LOW);
    //digitalWrite(reverse, LOW);
  }
}
