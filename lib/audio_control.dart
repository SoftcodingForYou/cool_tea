import 'package:audio_session/audio_session.dart';

class AudioHelper {
  AudioHelper._();
  static AudioHelper ah = AudioHelper._();
  AudioSession? session;
  Future<void> initAudioController() async {
    session = await initAudioService();
  }
  Future<void> setAudioState(bool state) async {
    // We use forced code exec stops because without, the true setting is 
    // too short-lived and does not allow for the sounds to be played 
    // completely or at all
    await Future.delayed(const Duration(milliseconds: 250));
    await session!.setActive(state);
    await Future.delayed(const Duration(milliseconds: 250));
  }
  
  Future<AudioSession> initAudioService() async {
    //audio_session INSTANCE
    final session = await AudioSession.instance;
    //audio_session DUCK OTHERS CONFIGURATION
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory:           AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions:    AVAudioSessionCategoryOptions.duckOthers,       // "none" and "duckOthers" reduce the background streams
      avAudioSessionMode:               AVAudioSessionMode.defaultMode,                 // No clear effect in this context
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.independent,   // "defaultPolicy" or "independent" are the only one working
      avAudioSessionSetActiveOptions:   AVAudioSessionSetActiveOptions.none,            // No clear effect in this context
      androidAudioAttributes:           AndroidAudioAttributes(
        contentType:                    AndroidAudioContentType.music,                  // No clear effect in this context
        flags:                          AndroidAudioFlags.none,                         // "audibilityEnforced" will increase volume a lot
        usage:                          AndroidAudioUsage.media,                        // Does not seem to have effect
      ),
      androidAudioFocusGainType:        AndroidAudioFocusGainType.gainTransient,        // "gain" will stop background stream without resuming. "gainTransient" seems fine
      androidWillPauseWhenDucked:       true,                                           // No clear effect in this context
    ));
    session.setActive(false);
    return session;

  }

}