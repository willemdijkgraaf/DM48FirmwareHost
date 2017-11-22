class HarmonicaGraphics {

  int controlWidth = 0; 
  int axisY = 0;
  final int maxBreathValue = 1024/2;
  float breathHeightRatio;
  int currentCmmand = -1;
  int sliderWidth = 0;
  int sliderX = 0;
  final int marginX = 5;
  int controlsY; 
  Harmonica _harmonica;
  
  HarmonicaGraphics(Harmonica harmonica) {
    _harmonica = harmonica;
    
    controlWidth = (width - 100)/12;
    sliderWidth = (width - (12 * controlWidth)) - marginX;
    sliderX = (12 * controlWidth) + marginX;
    
    axisY = (height / 3) * 2;
    controlsY = (height / 3);
    
    breathHeightRatio = (height/3) / (float)maxBreathValue;
  }
  
  void draw() {
    fill(255);
    stroke(255);
    
    int breathHeight;
    for (int i = 0; i<12; i++) {
      breathHeight = (int)(breathHeightRatio * _harmonica.mouthPiece.getBreathValue(i));
      rect(i * controlWidth, axisY, controlWidth - marginX, breathHeight);
    }
    
    //// draw slider
    rect(sliderX, axisY-13, sliderWidth * _harmonica.slide.getPositionAsRatio(), 26);
    
    // draw button values
    int controlX = 0;
    noFill();

    // Button UP
    if (_harmonica.buttons.isDownButtonPressed()) {
      fill(255);  
    }
    triangle(controlX,controlsY, controlX + controlWidth ,controlsY,controlX + (0.5 * controlWidth),(0.5 * controlsY));
    
    // Button DOWN
    controlX += controlWidth;
    noFill();
    if (_harmonica.buttons.isUpButtonPressed()) {
      fill(255);
    }
    triangle(controlX,0.5 * controlsY, controlX + controlWidth, 0.5 * controlsY, controlX + 0.5 * controlWidth, controlsY);
    
    // Button ROUND
    controlX += controlWidth;
    noFill();
    if (_harmonica.buttons.isRoundButtonPressed()) {
      fill(255);  
    }
    ellipse(controlX + 0.5 * controlWidth, controlsY - 0.5 * controlWidth, controlWidth,controlWidth);
    
    // Pressure sensor
    controlX += controlWidth;
    fill(255);
    rect(controlX, controlsY, controlWidth, - controlsY * _harmonica.controls.getPressureAsRatio());
    
    // Touch tensor
    controlX += controlWidth;
    fill(255);
    rect(controlX, controlsY, controlWidth, - controlsY * _harmonica.controls.getTouchAsRatio());
    
  }
}