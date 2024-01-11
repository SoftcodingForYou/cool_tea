import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:drink_your_tea/audio_control.dart';
import 'package:just_audio/just_audio.dart';


class AlarmManager {

  static final AudioPlayer _player = AudioPlayer();

  static bool isAlarmCompatible() {
    if (kIsWeb) {
      return false;
    } else {
      return true;
    }
  }

  static List<AlarmSettings> getAlarms() {
    List<AlarmSettings> alarms = Alarm.getAlarms();
    alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    return alarms;
  }

  static void setAlarm(String alarmType) {

    if (alarmType == "brewing" && isAlarmCompatible()) {
      final alarmSettingsBrewing = AlarmSettings(
        id: 42,
        dateTime: DateTime.now().add(const Duration(seconds: 1)),
        assetAudioPath: 'sounds/ButterflysWings.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'Your tea is done brewing',
        notificationBody: 'If you have set a cool-off timer, then you will receive another notification when your tea is at the right temperaure',
        enableNotificationOnKill: true,
      );
      Alarm.set(alarmSettings: alarmSettingsBrewing);
    } else if (alarmType == "cooling" && isAlarmCompatible()) {
      final alarmSettingsCooling = AlarmSettings(
        id: 43,
        dateTime: DateTime.now(),
        assetAudioPath: 'assets/ButterflysWings.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'Tea is now cold enough',
        notificationBody: 'What should I put here?',
        enableNotificationOnKill: true,
      );
      Alarm.set(alarmSettings: alarmSettingsCooling);
    } else {
      _player.setAsset('sounds/ButterflysWings.mp3');
      // AudioHelper.ah.setAudioState(true);
      _player.play();
      // AudioHelper.ah.setAudioState(false);
    }
  }

  static void cancelAlarms(String alarmType) {
    if (alarmType == "brewing") {
      if (isAlarmCompatible()) {
        Alarm.stop(42);
      } else {
        _player.stop();
      }
    } else if (alarmType == "cooling") {
        if (isAlarmCompatible()) {
        Alarm.stop(43);
      } else {
        _player.stop();
      }
    } else {
        if (isAlarmCompatible()) {
          Alarm.stop(42);
          Alarm.stop(43);
      } else {
        _player.stop();
      }
    }
  }

  // Not needed since we can just play an alarm right away when the timer finishes
  static DateTime setAlarmDateTime(int onsetDelay) {
    DateTime alarmDateTime = DateTime.now().add(Duration(minutes: onsetDelay));
    return alarmDateTime;
  }
}