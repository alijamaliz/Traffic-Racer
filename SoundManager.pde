import processing.sound.*;
class SoundManager {  
  private SoundFile[] sounds;
  AudioDevice device;
  public SoundManager(TrafficRacer parent) {
    sounds = new SoundFile[5];
    sounds[0] = new SoundFile(parent, "bg.mp3");
    sounds[1] = new SoundFile(parent, "horn.mp3");
    sounds[2] = new SoundFile(parent, "crash.mp3");
    sounds[3] = new SoundFile(parent, "start.mp3");
    sounds[4] = new SoundFile(parent, "idle.mp3");
    device = new AudioDevice(parent, 44000, 128);
  }
  public void playSound(String name) {
    switch(name) {
      case "horn": sounds[1].play(0.5, 1.0); break;
      case "accident": sounds[2].play(0.5, 1.0); break;
      case "start": sounds[3].play(0.5, 1.0); break;
    }
  }
  public void stopSound(String name) {
    switch(name) {
      case "horn": sounds[1].stop(); break;
      case "accident": sounds[2].stop(); break;
      case "start": sounds[3].stop(); break;
      case "idle": if (sounds[4].isPlaying() == 1) sounds[4].stop(); break;
    }
  }  
  public void loopSound(String name) {
    switch(name) {
      case "idle": {
        if (sounds[4].isPlaying() == 0) {
          sounds[4].amp(1); 
          sounds[4].play();
        } 
        break;
      }
    }
  }
  public void playBackgroundMusic() {
    sounds[0].amp(0.3);
    sounds[0].loop();
  }
}