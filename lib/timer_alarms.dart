import 'package:alarm/alarm.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:drink_your_tea/audio_control.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';


class AlarmManager {

  static final AudioPlayer _player = AudioPlayer();

  static const String pathAudio               = "assets/ButterflysWings.mp3";
  static const bool loopAudio                 = true;
  static const bool vibrate                   = true;
  static const double volume                  = 0.8;
  static const double fadeDuration            = 3.0;
  static const bool enableNotificationOnKill  = true;

  static const int brewingAlarmID             = 42;
  static const String brewingTitle            = 'Your tea is done brewing';
  static const String brewingBody             = 'The second timer will notify you when your tea has drinking temperature';
  static const int coolingAlarmID             = 43;
  static const String coolingTitle            = 'Your tea is cool now 8-)';
  static const String coolingBody             = 'Enjoy it!';

  static Timer brewingTimer                   = Timer(const Duration(minutes: 1), () {null;});
  static Timer coolingTimer                   = Timer(const Duration(minutes: 1), () {null;});


  static bool isAlarmCompatible() {
    if (kIsWeb) {
      return false;
    } else {
      return true;
    }
  }


  static setAlarm(
    String alarmType, DateTime timeAtStart, int delayMin) {

    if (alarmType == "brewing" && isAlarmCompatible()) {

      // Set up brewing alarm
      DateTime scheduledTime      = timeAtStart.add(Duration(minutes: delayMin));
      AlarmSettings alarmSettingsBrewing = AlarmSettings(
        id:                       AlarmManager.brewingAlarmID,
        dateTime:                 scheduledTime,
        assetAudioPath:           AlarmManager.pathAudio,
        loopAudio:                AlarmManager.loopAudio,
        vibrate:                  AlarmManager.vibrate,
        volume:                   AlarmManager.volume,
        fadeDuration:             AlarmManager.fadeDuration,
        notificationTitle:        AlarmManager.brewingTitle,
        notificationBody:         AlarmManager.brewingBody,
        enableNotificationOnKill: AlarmManager.enableNotificationOnKill,
      );
      print("set new brewing alarm");
      Alarm.set(alarmSettings: alarmSettingsBrewing);

    } else if (alarmType == "cooling" && isAlarmCompatible()) {

      // Set up cool-off alarm
      // Set up brewing alarm
      DateTime scheduledTime      = timeAtStart.add(Duration(minutes: delayMin));
      AlarmSettings alarmSettingsCooling = AlarmSettings(
        id:                       AlarmManager.coolingAlarmID,
        dateTime:                 scheduledTime,
        assetAudioPath:           AlarmManager.pathAudio,
        loopAudio:                AlarmManager.loopAudio,
        vibrate:                  AlarmManager.vibrate,
        volume:                   AlarmManager.volume,
        fadeDuration:             AlarmManager.fadeDuration,
        notificationTitle:        AlarmManager.coolingTitle,
        notificationBody:         AlarmManager.coolingBody,
        enableNotificationOnKill: AlarmManager.enableNotificationOnKill,
      );
      print("set new cooling alarm");
      Alarm.set(alarmSettings: alarmSettingsCooling);

    } else if (alarmType == "brewing" && !isAlarmCompatible()) {

      _player.setAsset(AlarmManager.pathAudio);
      // AudioHelper.ah.setAudioState(true);
      brewingTimer = Timer(Duration(minutes: delayMin), () {_player.play();});
      // AudioHelper.ah.setAudioState(false);
    
    } else if (alarmType == "cooling" && !isAlarmCompatible()) {

      _player.setAsset(AlarmManager.pathAudio);
      // AudioHelper.ah.setAudioState(true);
      coolingTimer = Timer(Duration(minutes: delayMin), () {_player.play();});
      // AudioHelper.ah.setAudioState(false);
    }

  }


  static void cancelAlarms(String alarmType) async {
    if (alarmType == "brewing") {
      if (isAlarmCompatible()) {
        await Alarm.stop(AlarmManager.brewingAlarmID);
      } else {
        brewingTimer.cancel();
        await _player.stop();
      }
    } else if (alarmType == "cooling") {
      if (isAlarmCompatible()) {
        await Alarm.stop(AlarmManager.coolingAlarmID);
      } else {
        coolingTimer.cancel();
        await _player.stop();
      }
    } else {
        if (isAlarmCompatible()) {
          await Alarm.stop(AlarmManager.brewingAlarmID);
          await Alarm.stop(AlarmManager.coolingAlarmID);
      } else {
        brewingTimer.cancel();
        coolingTimer.cancel();
        await _player.stop();
      }
    }
  }

}