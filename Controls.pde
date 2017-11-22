import java.util.Observable;

class Controls extends Observable {
  int _pressure = 0;
  int _touch = 0;
  
  final int _maxPressure = 1024;
  
  // TOUCH
  void setPressure(int value) {
    if (_pressure != value) {
      _pressure = value;
      setChanged();
      notifyObservers();
    }
  }
  
  int getPressure () {
    return _pressure;
  }
  
  float getPressureAsRatio(){
    return (float)_pressure/_maxPressure;
  }


  // TOUCH
  void setTouch(int value) {

  //if (value < 0) {value = value * -1;} else {  value = value + 600;}
  
  println(value);
  if (_touch != value) {
      _touch = value;
      setChanged();
      notifyObservers();
    }
  }
  
  int getTouch(){
    return _touch;
  }
  
  float getTouchAsRatio(){
    return (float)_touch/_maxPressure;
  }
}