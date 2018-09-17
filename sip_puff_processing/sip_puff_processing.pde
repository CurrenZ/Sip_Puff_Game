import processing.serial.Serial;

static final int PORT_INDEX = 0, BR = 115200;

String myString;
int current_mpxv;
int[] mpxv_array;
int window_size;

void setup(){
  size(1280, 720);
  window_size = width - 10;
  strokeWeight(3);
  smooth();
  mpxv_array = new int[window_size];
  
  noLoop();
  final String[] ports = Serial.list();
  printArray(ports);
  new Serial(this, ports[PORT_INDEX], BR).bufferUntil(ENTER);
}

void draw(){
  background(55);
  current_mpxv = int(myString);
  current_mpxv = int(map(current_mpxv, 1023, 0, 128, height - 128));
  for (int i = 1; i < window_size; i ++){
    mpxv_array[i - 1] = mpxv_array[i];
  }
  mpxv_array[window_size - 1] = current_mpxv;
  //stroke(255, 200, 0);
  line(window_size, current_mpxv, width, current_mpxv);
  strokeWeight(5);
  line(0, current_mpxv, width, current_mpxv);
  strokeWeight(8);
  for(int i = 1; i < window_size; i ++) {
      stroke(220, 75, mpxv_array[i]);
      point(i, mpxv_array[i]);
  }
  println(current_mpxv);
}

void serialEvent(final Serial s){
  myString = s.readString().trim();
  redraw = true;
}
