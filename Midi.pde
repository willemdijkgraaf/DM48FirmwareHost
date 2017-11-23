import themidibus.*;

class Midi {
  private final int MIDIBREATHCC = 2;
  private final int MODULATIONCC = 1;
  private final int TOUCHCC = 19;
  //private final String midiOutBusName = "loopMIDI Port 1"; // when using my Windows machine
  private final String midiOutBusName = "Bus 1"; // when using my Apple machine
  
  private ControlChange _breathController;
  //private boolean _breathControllerValueChanged;
  private int _noteOffPitch = -1; // -1 = no note to turn off
  private int[] _channels;
  private HarmonicaState _previousState = new HarmonicaState();
  private MidiBus outputBus;
  
  Midi(int[] channels){
    _channels = channels;
    _breathController = new ControlChange(0,0,0);
    _breathController.channel = 0;
    _breathController.number = 2; 
    MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
    outputBus = new MidiBus(null, "", midiOutBusName);
  }
  
  void update(HarmonicaState state){
    // note on/off
    int numberOfChannels = _channels.length;
    if (state != null) {
      // not playing -> send note off
      if (!state.isPlaying) {
        outputBus.sendNoteOff(0, _noteOffPitch, 0);
        _noteOffPitch = -1;
      }
      
      if (hasPitchChanged(state)) {
        // turn off previous note
        if (_noteOffPitch != -1) {
          outputBus.sendNoteOff(0, _noteOffPitch, 0);
          _noteOffPitch = -1;
        }
        
        if (state.isPlaying) {
          outputBus.sendNoteOn(0, state.pitch, 100);
          _noteOffPitch = state.pitch;
        }
      }
      
      // CC2 - BREATH CONTROL
      if (_previousState.breathValue != state.breathValue) {
        int breathValue = state.breathValue;
        if (state.isSlideIn) {
          breathValue = (int)(breathValue * state.slideRatio);
        } else {
          breathValue = (int)(breathValue * (1 - state.slideRatio));
        }
        
        if (!state.isBlowing()) {breathValue = breathValue * -1;}
        //for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
          int channel = 0; //_channels[channelIndex];
          ControlChange cc = new ControlChange(channel, MIDIBREATHCC, breathValue);
          outputBus.sendControllerChange(cc);
        //}
      }
    
      // CC1 - MODULATION WHEEL
      if (_previousState.pressure != state.pressure) {
        //for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
          int channel = 0; //_channels[channelIndex];
          ControlChange cc = new ControlChange(channel, MODULATIONCC, (int)map((float)state.pressure, 0, 1024, 0, 127));
          outputBus.sendControllerChange(cc);
        //}
      }
      
      // 19 - Vibrato Rate
      if (_previousState.touch != state.touch) {
        //for (int channelIndex = 0; channelIndex < numberOfChannels; channelIndex = channelIndex+1) {
          int channel = 0; //_channels[channelIndex];
          ControlChange cc = new ControlChange(channel, TOUCHCC, (int)map((float)state.touch, -400, 600, 0, 70));
          outputBus.sendControllerChange(cc);
        //}
      }
      
      _previousState = state.clone();
    }
  }
  
  private boolean hasPitchChanged(HarmonicaState state) {
    return 
      state.isSlideIn != _previousState.isSlideIn ||
      state.isBlowing() != _previousState.isBlowing() ||
      state.hole != _previousState.hole ||
      state.isPlaying != _previousState.isPlaying;
  }
}