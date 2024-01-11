import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:drink_your_tea/timer_alarms.dart';
import 'package:drink_your_tea/colors.dart';


class TimerBasic extends StatelessWidget {
  final CountDownTimerFormat format;
  final int duration;
  final int durationAdded;


  const TimerBasic({
    required this.format,
    required this.duration,
    this.durationAdded = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return (duration > 0)? TimerCountdown(
      format: format,
      endTime: DateTime.now().add(
        Duration(
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: duration + durationAdded,
        ),
      ),
      onEnd: () {
        if (durationAdded == 0) {
          showTimerEndedPopup(context, "brewing");
          AlarmManager.setAlarm("brewing");
        } else {
          showTimerEndedPopup(context, "cooling");
          AlarmManager.setAlarm("cooling");
        }
      },
      timeTextStyle: TextStyle(
        color: ColorManager.lightColor,
        fontWeight: FontWeight.w300,
        fontSize: 40,
        fontFeatures: const <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      colonsTextStyle: TextStyle(
        color: ColorManager.lightColor,
        fontWeight: FontWeight.w300,
        fontSize: 40,
        fontFeatures: const <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      descriptionTextStyle: TextStyle(
        color: ColorManager.lightColor,
        fontSize: 14,
        fontFeatures: const <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      spacerWidth: 5,
      daysDescription: "days",
      hoursDescription: "hours",
      minutesDescription: "minutes",
      secondsDescription: "seconds",
    ) : const Text("No timer set");
  }


  void showTimerEndedPopup(BuildContext context, String alarmType) {

    String dialogTitle    = "";
    String imagePath      = "";
    if (alarmType == "brewing") {
      dialogTitle         = "Your tea is done brewing";
      imagePath           = "animations/tea-79.gif";
    } else if (alarmType == "cooling") {
      dialogTitle         = "Tea is now cool 8-)";
      imagePath           = "animations/tea-51.gif";
    }

    showCupertinoModalPopup<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(dialogTitle),
        content: Image.asset(imagePath),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              AlarmManager.cancelAlarms(alarmType);
              Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      )
    );
  }

}