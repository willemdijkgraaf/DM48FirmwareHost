import java.util.Observable;

class Slide extends Observable {
  int _value;
  
  final int _minValue = 140;
  final float _maxValue = 1024 - _minValue;
  
  void setPosition (int value) {
    if (_value != value) {
      _value = value - _minValue;
      setChanged();
      notifyObservers();
    }
  }
  
  float getPositionAsRatio() {
    return (float)_value / _maxValue;
  }
  
  boolean isIn() {
    return getPositionAsRatio() >= 0.5;
  }
  
  boolean isOut() {
    return getPositionAsRatio() < 0.5;
  }
  
  int getPosition() {
    return _value;
  }
}