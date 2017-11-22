class HarmonicaState {
  int hole;
  int breathValue;
  int octave = 0;
  int pitch = -1;
  int pressure = 0;
  int touch = 0;
  float slideRatio;
  boolean isSlideIn;
  boolean isPlaying;
  
  void toConsole() {
    println("hole:   " + hole);
    println("breath: " + breathValue);
    println("octave: " + octave);
    println("pitch:  " + pitch);
    println("slide%: " + slideRatio);
    println("slideIn:" + isSlideIn);
    println("blowing:" + isBlowing());
    println("playing:" + isPlaying); 
    println("press.: " + pressure);
    println("touch:  " + touch);
  }
  
  HarmonicaState clone() {
    HarmonicaState newState = new HarmonicaState();
    newState.breathValue = this.breathValue;
    newState.hole = this.hole;
    newState.isPlaying = this.isPlaying;
    newState.isSlideIn = this.isSlideIn;
    newState.octave = this.octave;
    newState.pitch = this.pitch;
    newState.slideRatio = this.slideRatio;
    newState.pressure = this.pressure;
    newState.touch = this.touch;
    return newState;
  }
  
  boolean isBlowing() {
    return breathValue > 0;
  }
  
  int absBreathValue() {
    if (breathValue < 0) {
      return breathValue * -1;
    }
    return breathValue;
  }
}