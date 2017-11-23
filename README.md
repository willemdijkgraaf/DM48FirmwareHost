# DM48FirmwareHost
P3 (processing.org) based host to be used with DM48 MIDI harmonica firmware.

System setup:

- DM48 MIDI Harmonica running on a Teensy 2.0 using firmware from DM48Firmware repo. Connected with an USB cable. Firmware can be uploaded to DM48 using Arduino IDE.
- Additional Teensy 3.1 using firmware from DM482ndControllerFirmware. Connected with an USB cable. Firmware can be uploaded to Teensy 3.1 using Arduino IDE.
- P3 sketch: SLIPSerialToUDPp3 running on host computer. Puts incoming OSC messages (SLIPSerial) on UDP network or address 127.0.0.1
- P3 sketch: DM48FirmwareHost contains all the logic to receive OSC messages and translate them to proper MIDI messages.

Does not include a sound generator.

Demo video and explanation of this setup: https://www.youtube.com/watch?v=svXEzs4MTUE 
