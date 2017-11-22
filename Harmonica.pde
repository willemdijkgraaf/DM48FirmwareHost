import java.util.Observer;
import java.util.Observable;


class Harmonica implements Observer {
  final int threshhold = 5;
  
  MouthPiece mouthPiece;
  Buttons buttons;
  Slide slide;
  Controls controls;
  Midi _midi;
  Tuning _tuning;
  HarmonicaState _state;

  
  Harmonica () {
    mouthPiece = new MouthPiece(threshhold);
    mouthPiece.addObserver(this);
    buttons = new Buttons();
    buttons.addObserver(this);
    slide = new Slide();
    slide.addObserver(this);
    controls = new Controls();
    controls.addObserver(this);
    
    _state = new HarmonicaState();
    _state.isPlaying = false;
    _tuning = new Tuning();
    
    int[] channels = new int[] {1};
    _midi = new Midi(channels);
  }
  
  public void update(Observable obs, Object obj){
    if (obs == mouthPiece) {
      updateStateMouthPiece();
      _midi.update(_state);
    }
  
    if (obs == buttons) {
      //println("buttons");
      if (_harmonica.buttons.isDownButtonPressed()){
        _state.octave = _state.octave -1;
        if (_state.octave < -3) {_state.octave = -3;}
        _midi.update(_state);
        return;
      }
      if (_harmonica.buttons.isUpButtonPressed()){
        _state.octave = _state.octave + 1;
        if (_state.octave > 7) {_state.octave = 7;}
        _midi.update(_state);
        return;
      }
      
      //_state.octave = 0;
      
    }
    
    if (obs == slide) {
      updateStateSlide();
      _midi.update(_state);
    }
    
    if (obs == controls) {
       _state.pressure = controls.getPressure();
       _state.touch = controls.getTouch();
       _midi.update(_state);
    }
    
    //_state.toConsole();
  }
  
  void updateStateMouthPiece(){
    int holeNumber = mouthPiece.getCurrentHoleNumber();
    int breathValue = mouthPiece.getBreathValue(holeNumber);
    if ((_state.hole != holeNumber) || (_state.breathValue != breathValue)) {
      _state.hole = holeNumber;
      _state.breathValue = breathValue;
      _state.isPlaying = (breathValue != 0); //no sound -> all breath values are below threshhold
      if (_state.isPlaying) {
        _state.pitch = _tuning.getPitch(_state);
      }
    }
  }
  
  void updateStateSlide() {
    if (_state.isSlideIn != slide.isIn()){
        _state.isSlideIn = slide.isIn();
        _state.pitch = _tuning.getPitch(_state);
    }
    
    _state.slideRatio = slide.getPositionAsRatio();
    
  }
}