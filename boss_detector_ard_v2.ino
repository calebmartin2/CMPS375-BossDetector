const int trigPin = 11; const int echoPin = 12;
const int trigPin2 = 10; const int echoPin2 = 9;
const int led = 3; float distance = 0; float distance2 = 0;
void setup(){
  Serial.begin (9600);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  pinMode(led, OUTPUT);
}
void loop() {
//  distance = getDistance(trigPin, echoPin);
  distance2 = getDistance(trigPin2, echoPin2);
//  if (distance <= 10 && distance2 <= 10) {
if ((distance2 <= 40 && !(distance2 == 0.0)) || distance2 > 400.0) {
    digitalWrite(led, HIGH);
    Serial.print('Y');
  }
  else {
    digitalWrite(led, LOW);  
    Serial.print('N');
  }
//  Serial.println(distance2);
  delay(200);
}
float getDistance(int tPin, int ePin){
  float echoTime;
  digitalWrite(tPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(tPin, LOW);
  echoTime = pulseIn(ePin, HIGH);
  return echoTime / 148.0;
}
