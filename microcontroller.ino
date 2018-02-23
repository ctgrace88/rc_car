char val;
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
}
 
void loop() {
  if( Serial.available() ) // if data is available to read
  {
    val = Serial.read(); // read it and store it in 'val'
  }
  if( val == 'H' ) // if 'H' was received
  {
    digitalWrite(LED_BUILTIN, HIGH); // turn ON the LED
  } else {
    digitalWrite(LED_BUILTIN, LOW); // otherwise turn it OFF
  }
  //digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
  //delay(250);                       // wait for a second
  //digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  //delay(250);                       // wait for a second
}
