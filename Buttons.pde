import java.util.Observable;

class Buttons extends Observable {
  
  final int _upButtonBitMask = 1;
  final int _downButtonBitMask = 2;
  final int _slideButtonBitMask = 4;
  final int _roundButtonBitMask = 8;
  
  int _buttonsBitMask;
  
  void setButtons(int buttonsBitMask) {
    if (_buttonsBitMask != buttonsBitMask) {
      _buttonsBitMask = buttonsBitMask;
      setChanged();
      notifyObservers();
    }  
  }
  
  boolean isUpButtonPressed() {
    return (_buttonsBitMask & _upButtonBitMask) > 0;
  }
  boolean isDownButtonPressed() {
    return (_buttonsBitMask & _downButtonBitMask) > 0;
  }
  boolean isSlideButtonPressed() {
    return (_buttonsBitMask & _slideButtonBitMask) > 0;
  }
  boolean isRoundButtonPressed() {
    return (_buttonsBitMask & _roundButtonBitMask) > 0;
  }
}