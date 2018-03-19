byte state[] = {0,0,0,0,0};
int stateLoop = 0;
int ledPin = 13;
int left = 7;
int forward = 6;
int right = 5;
int reverse = 4;
//const int txPin = 9;
//const int rxPin = 10;

void setup() {
  pinMode(ledPin, OUTPUT);   // Set pin as OUTPUT
  pinMode(left, OUTPUT);
  pinMode(forward, OUTPUT);
  pinMode(right, OUTPUT);
  pinMode(reverse, OUTPUT);
  Serial.begin(9600);            // Start serial communication at 9600 bps
}

void loop() {
  stateLoop = 0;
  while (stateLoop <= 4) {
    if (Serial.available()) {
      state[stateLoop] = Serial.read();
      stateLoop++;
    }
  }
  if (state[1] == 1) {
    digitalWrite(left, HIGH);    // turn the LED on
  }
  else {
    digitalWrite(left, LOW);   // otherwise turn it off
  }
  if (state[2] == 1) {
    digitalWrite(forward, HIGH);    // turn the LED on
  }
  else {
    digitalWrite(forward, LOW);   // otherwise turn it off
  }
  if (state[3] == 1) {
    digitalWrite(right, HIGH);    // turn the LED on
  }
  else {
    digitalWrite(right, LOW);   // otherwise turn it off
  }
  if (state[4] == 1) {
    digitalWrite(reverse, HIGH);    // turn the LED on
  }
  else {
    digitalWrite(reverse, LOW);   // otherwise turn it off
  }
}
