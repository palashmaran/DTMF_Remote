import oscP5.*;
import netP5.*;

import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.content.Context;
import android.media.MediaPlayer;
import android.media.SoundPool;
import android.media.AudioManager;


OscP5 oscP5, sender;
NetAddress myRemoteLocation;

SoundPool soundPool;
HashMap<Object, Object> soundPoolMap;
Activity act;
Context cont;
AssetFileDescriptor afd1, afd2, afd3, afd4, afd5, afd6, afd7, afd8, afd9, afd0;
int s1, s2, s3, s4, s5, s6, s7, s8, s9, s0;
int streamId;

int w = width/3;
int h = height/2;

int last = 0, delay = 800;
String ip = "10.1.120.61";
// 10.1.123.72

void setup() {
  background(0);
  fullScreen();
  frameRate(25);

  ip = loadStrings("/sdcard/iot.txt")[0];
  
  oscP5 = new OscP5(this, 12000);
  sender = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress(ip, 12000);

  w = width/3;
  h = height/2;

  for (int j=0; j<2; j++) {
    for (int i=0; i<3; i++) {
      fill(255);
      if (!((i==0 && j==0) || (i==2 && j==0))) {
        rect(i*w +5, j*h +5, w-10, h-10);
        int ox = i*w +5;
        int oy = j*h +5;
        int lx = ox + w-10;
        int ly = oy + h-10;
        //println(ox + ", " + oy + ", " + lx + ", " + ly);
      }
    }
  }

  last = millis();
  
  
  
  act = this.getActivity();
  cont = act.getApplicationContext();

  // load up the files
  try {
    afd1 = cont.getAssets().openFd("DTMF-1.mp3");
    afd2 = cont.getAssets().openFd("DTMF-2.mp3");
    afd3 = cont.getAssets().openFd("DTMF-3.mp3");
    afd4 = cont.getAssets().openFd("DTMF-4.mp3");
    afd5 = cont.getAssets().openFd("DTMF-5.mp3");
    afd6 = cont.getAssets().openFd("DTMF-6.mp3");
    afd7 = cont.getAssets().openFd("DTMF-7.mp3");
    afd8 = cont.getAssets().openFd("DTMF-8.mp3");
    afd9 = cont.getAssets().openFd("DTMF-9.mp3");
    afd0 = cont.getAssets().openFd("DTMF-0.mp3");
  } 
  catch(IOException e) {
    println("error loading files:" + e);
  }

  // create the soundPool HashMap - apparently this constructor is now depracated?
  soundPool = new SoundPool(12, AudioManager.STREAM_MUSIC, 0);
  soundPoolMap = new HashMap<Object, Object>(10);
  soundPoolMap.put(s1, soundPool.load(afd1, 1));
  soundPoolMap.put(s2, soundPool.load(afd2, 2));
  soundPoolMap.put(s3, soundPool.load(afd3, 3));
  soundPoolMap.put(s4, soundPool.load(afd4, 4));
  soundPoolMap.put(s5, soundPool.load(afd5, 5));
  soundPoolMap.put(s6, soundPool.load(afd6, 6));
  soundPoolMap.put(s7, soundPool.load(afd7, 7));
  soundPoolMap.put(s8, soundPool.load(afd8, 8));
  soundPoolMap.put(s9, soundPool.load(afd9, 9));
  soundPoolMap.put(s0, soundPool.load(afd0, 0));
}


void draw() {
  if (mousePressed) {
    if (mouseX > 245 && mouseY > 5 && mouseX < 475 && mouseY < 587 && ((millis() - delay) > last)) {
      println("1");
      last = millis();

      OscMessage myMessage = new OscMessage("1");
      myMessage.add(123);
      //oscP5.send(myMessage, myRemoteLocation);
      sender.send(myMessage, myRemoteLocation);
    }
    if (mouseX > 5 && mouseY > 597 && mouseX < 235 && mouseY < 1179 && ((millis() - delay) > last)) {
      println("2");
      last = millis();

      OscMessage myMessage = new OscMessage("2");
      myMessage.add(123);
      sender.send(myMessage, myRemoteLocation);
    }
    if (mouseX > 245 && mouseY > 597 && mouseX < 475 && mouseY < 1179 && ((millis() - delay) > last)) {
      println("3");
      last = millis();

      OscMessage myMessage = new OscMessage("3");
      myMessage.add(123);
      sender.send(myMessage, myRemoteLocation);
    }
    if (mouseX > 485 && mouseY > 597 && mouseX < 715 && mouseY < 1179 && ((millis() - delay) > last)) {
      println("4");
      last = millis();

      OscMessage myMessage = new OscMessage("4");
      myMessage.add(123);
      sender.send(myMessage, myRemoteLocation);
    }
  }
}

void oscEvent(OscMessage theOscMessage) {
  String value = theOscMessage.addrPattern();
  
  print("### received an osc message.");
  print(" addrpattern: "+ value);
  println(" typetag: "+theOscMessage.typetag());
  
  if(value.equals("1")){
    println("1 received");
    playSound(5);
  }
  else if(value.equals("2")){
    println("2 received");
    playSound(1);
  }
  else if(value.equals("3")){
    println("3 received");
    playSound(3);
  }
  else if(value.equals("4")){
    println("4 received");
    playSound(4);
  }
  else if(value.equals("5")){
    println("5 received");
    playSound(5);
  }
  else if(value.equals("6")){
    println("6 received");
    playSound(6);
  }
  else if(value.equals("7")){
    println("7 received");
    playSound(7);
  }
  else if(value.equals("8")){
    println("8 received");
    playSound(8);
  }
  else if(value.equals("9")){
    println("9 received");
    playSound(9);
  }
  else if(value.equals("0")){
    println("0 received");
    playSound(0);
  }
}