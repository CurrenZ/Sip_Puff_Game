#define MPXV A4

void setup() {
  Serial.begin(115200);
  pinMode(MPXV, INPUT);
}

void loop() {
  int mpxv = analogRead(MPXV);
  Serial.println(mpxv);
}
