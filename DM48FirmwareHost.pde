import oscP5.*;

OscP5 _oscP5;
Harmonica _harmonica;
HarmonicaGraphics _harmonicaGraphics;
boolean _isCalibrating = false;

void setup() {
  size(500,200);
  
    
  _oscP5 = new OscP5(this,10001);
  _harmonica = new Harmonica();
  _harmonicaGraphics = new HarmonicaGraphics(_harmonica);
  frameRate(30);
}

void draw() {
  background(0);
  // draw breath values
  
  _harmonicaGraphics.draw();
}

void oscEvent(OscMessage theOscMessage) {
  if (_isCalibrating) return;
  
  // Hole
  if (theOscMessage.checkAddrPattern("/DM48/hole") && theOscMessage.checkTypetag("ii") ) {
   int holeNumber = theOscMessage.get(0).intValue();
   int breathValue = theOscMessage.get(1).intValue();
   _harmonica.mouthPiece.setBreathValue(holeNumber, breathValue);
    return;
  }
  // Buttons
  if (theOscMessage.checkAddrPattern("/DM48/buttons") && theOscMessage.checkTypetag("i")) { 
    int buttonsBitMask = theOscMessage.get(0).intValue();
    _harmonica.buttons.setButtons(buttonsBitMask);
    
    return;
  }
  // Slider
  if (theOscMessage.checkAddrPattern("/DM48/slider") && theOscMessage.checkTypetag("i")) {
     _harmonica.slide.setPosition(theOscMessage.get(0).intValue());
     return;
  }
  // Pressure
  if (theOscMessage.checkAddrPattern("/DM48/pressure") && theOscMessage.checkTypetag("i")) {
   _harmonica.controls.setPressure(theOscMessage.get(0).intValue());
   return;
  }
  
  // Touch
   if (theOscMessage.checkAddrPattern("/DM48/touch") && theOscMessage.checkTypetag("i")) {
   _harmonica.controls.setTouch(theOscMessage.get(0).intValue());
   return;
  }
  
  // Calibrate
  if (theOscMessage.checkAddrPattern("/DM48/calibrate") && theOscMessage.checkTypetag("iiiiiiiiiiiiiiiiiiiiiiii")) {
    _isCalibrating = true;
    for (int i = 0; i < 12; i++) { 
      int index = i * 2;
      int holeNumber = theOscMessage.get(index).intValue();
      int breathValue = theOscMessage.get(index+1).intValue();
      _harmonica.mouthPiece.calibrate(holeNumber, breathValue);
    }
    _isCalibrating = false;
    return; 
  }
}