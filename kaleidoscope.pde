/**
 * Kaleidoscope
 *
 **/
 
 import processing.video.*;
 
 PImage quarterFrame;
 Capture camera;
 int numPixels;
 int quarterFrameNumPixels;
 
 void setup() {
   size(1280, 720);

   quarterFrame = createImage(width/2, height/2, RGB);
   
   camera = new Capture(this, 1280, 720);
   camera.start();
   
   numPixels = width * height;
   quarterFrameNumPixels = quarterFrame.width * quarterFrame.height;
   
   background(0);
 }
 
 void draw() {
   if (camera.available()) {
     quarterFrame.loadPixels();
     camera.read();
     camera.loadPixels();
      
      // load up the pixels into the quarterFrame
      int cameraIndex;
      for (int i = 0; i < quarterFrameNumPixels; i++) {
        cameraIndex = (camera.width * (i/quarterFrame.width)) + (i % quarterFrame.width);
        quarterFrame.pixels[i] = camera.pixels[cameraIndex];
      }
      
      quarterFrame.updatePixels();
      
      // draw quarterframe in upper left
      image(quarterFrame, 0, 0);
     
      // mirror quarterframe across x axis in lower left
      pushMatrix();
      scale(1, -1);
      image(quarterFrame, 0,  - 2 * quarterFrame.height);
      popMatrix();
      
      // mirror quarterframe across y axis in upper right
      pushMatrix();
      scale(-1, 1);
      image(quarterFrame, - 2 * quarterFrame.width,  0);
      popMatrix();
      
      // mirror quarterframe across y axis and across x axis in lower right
      pushMatrix();
      scale(-1, -1);
      image(quarterFrame, - 2 * quarterFrame.width,  - 2 * quarterFrame.height);
      popMatrix();
   }
 }