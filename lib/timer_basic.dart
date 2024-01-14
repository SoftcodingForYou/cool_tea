import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:cool_tea/timer_alarms.dart';
import 'package:cool_tea/colors.dart';


class TimerBasic extends StatelessWidget {
  final CountDownTimerFormat format;
  final int duration;
  final int durationAdded;
  final DateTime startTime;


  const TimerBasic({
    required this.format,
    required this.duration,
    this.durationAdded = 0,
    required this.startTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(duration);
    print(durationAdded);

    return (duration > 0)? TimerCountdown(
      format: format,
      endTime: startTime.add(
        Duration(
          days: 0,
          hours: 0,
          minutes: duration + durationAdded,
          seconds: 1,
        ),
      ),
      onEnd: () {
        if (durationAdded == 0) {
          showTimerEndedPopup(context, "brewing");
        } else {
          showTimerEndedPopup(context, "cooling");
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
    ) : const Padding(padding: EdgeInsets.all(15), child: Text("No timer set"));
  }


  void showTimerEndedPopup(BuildContext context, String alarmType) {

    String dialogTitle    = "";
    String imagePath      = "";
    if (alarmType == "brewing") {
      dialogTitle         = "Your tea is done brewing";
      imagePath           = "assets/tea-79.gif";
    } else if (alarmType == "cooling") {
      dialogTitle         = "Tea is now cool 8-)";
      imagePath           = "assets/tea-51.gif";
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