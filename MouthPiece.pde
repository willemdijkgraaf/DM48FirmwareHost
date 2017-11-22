import java.util.Observable;

class MouthPiece extends Observable {
  int[] _breathValues = new int[12];
  int[] _breathCalibrationValues = new int[12];
  
  int _threshhold;
  
  MouthPiece(int threshhold) {
    _threshhold = threshhold;
  }
  
  void setBreathValue (int holeNumber, int breathValue) {
    if (_breathValues[holeNumber] != breathValue) {
      int calibationValue = _breathCalibrationValues[holeNumber];
      int value = breathValue - calibationValue;
      _breathValues[holeNumber] = value;
      
      setChanged();
      notifyObservers();
      
      // only notify if outside of threshhold
      //if (!(value > -_threshhold && value < _threshhold))  {
      //  setChanged();
      //  notifyObservers();
      //}
    }
  }
  
  int getCurrentHoleNumber() {
    int maxValue = 0;
    int holeNumber = -1;
    for (int i = 0; i < 12; i++) {
      int value = _breathValues[i];
      if (value < 0) {value = value * -1;}
      if (value > maxValue) {maxValue = value; holeNumber = i;}
    }
    if (maxValue > -_threshhold && maxValue < _threshhold) {return -1;}
    //println("maxValue: " + maxValue + " threshhold: " + _threshhold);
    return holeNumber;
  }
  
  int getBreathValue (int holeNumber) {
    if (holeNumber == -1) {return 0;}
    return _breathValues[holeNumber];
  }
  
  void calibrate (int holeNumber, int breathValue) {
    _breathCalibrationValues[holeNumber] = breathValue;
  }
}