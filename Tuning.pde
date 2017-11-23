// translates whole tone tuning to solo tuning
class Tuning {
  
  private int[] soloTuningTable = new int[256];
  private int[] soloTuning = new int[16];
  private MusicMath mm = new MusicMath();
  
  Tuning() {
    soloTuning[0] = mm.c_1;
    soloTuning[1] = mm.cs_1;
    soloTuning[2] = mm.d_1;
    soloTuning[3] = mm.ds_1;
    
    soloTuning[4] = mm.e_1;
    soloTuning[5] = mm.f_1;
    soloTuning[6] = mm.f_1;
    soloTuning[7] = mm.fs_1;
    
    soloTuning[8] = mm.g_1;
    soloTuning[9] = mm.gs_1;
    soloTuning[10] = mm.a_1;
    soloTuning[11] = mm.as_1;
    
    soloTuning[12] = mm.c0;
    soloTuning[13] = mm.cs0;
    soloTuning[14] = mm.b_1;
    soloTuning[15] = mm.c0;
    
    int i = 0;
    for (int octaves = 0; octaves < 128; octaves = octaves + 12) {
      for (int index = 0; index < 16; index = index + 1) {
        int pitch = soloTuning[index] + octaves;
        //println ("pitch: " + (i) + " -> " + pitch);
        soloTuningTable[i] = pitch;
        i = i + 1;
      }
    }
  }
  
  public int getPitch(HarmonicaState state) {
    int wholeTone = 0;
    if (!state.isBlowing()) {wholeTone = 2;}
    
    int semiTone = 0;
    if (state.isSlideIn) {semiTone = 1;};
    
    int wholeToneBasedPitch = 5*16 + (state.octave * 16) + (state.hole * 4) + wholeTone + semiTone;
    return soloTuningTable[wholeToneBasedPitch];
  }
}