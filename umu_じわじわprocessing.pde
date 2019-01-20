import ddf.minim.*;
import processing.serial.*;

// myPort（任意名）というインスタンスを用意
Serial myPort;
int vol_value;

import processing.sound.*;//Soundライブラリを読み込む
SoundFile soundfile;//サウンドプレイヤ

Minim minim;
AudioPlayer player;

void setup() {
  myPort = new Serial(this, "/dev/tty.usbmodem143301", 9600);
  size(800, 400, P3D);
  minim = new Minim(this);

  player = minim.loadFile("beat2.wav");
  player.loop();
  
  stroke(255, 255, 255);
  noFill();
  strokeWeight(2);  
}

void draw() {
if(vol_value > 30){
background(0);
for (int i = 0; i < player.bufferSize() - 1; i++) {
    float x = map(i, 0, player.bufferSize(), 0, width) ;
    float y = map(player.left.get(i), -1, 1, 0, height);
    point(x, y);
}
translate(0, height);
for (int i = 0; i < player.bufferSize() - 1; i++) {
    float x = map(i, 0, player.bufferSize(), 0, width) ;
    float y = map(player.right.get(i), -1, 1, 0, height);
    point(x, y);
}
}
}

void serialEvent(Serial p){
  if(p.available()>0){
  vol_value = p.read();
  p.clear();
  }
}