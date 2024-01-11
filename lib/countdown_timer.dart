import 'package:flutter/cupertino.dart';
import 'package:drink_your_tea/timer_basic.dart';
import 'package:drink_your_tea/timer_frame.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:drink_your_tea/user_settings.dart';
import 'package:drink_your_tea/timer_alarms.dart';
import 'package:flutter/material.dart';
import 'package:drink_your_tea/home.dart';
import 'package:drink_your_tea/colors.dart';


class CountdownTimer extends StatefulWidget {
  final DateTime startTime;

  const CountdownTimer({
    required this.startTime,
    Key? key,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  
  int brewingDuration     = SPHelper.sp.getInt("brewingDuration")!;
  int coolOffDuration     = SPHelper.sp.getInt("coolOffDuration")!;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Column(
                  children: [

                    // Time until brewed
                    // ----------------------------------------------------
                    TimerFrame(
                      description: 'Time until tea is brewed',
                      timer: TimerBasic(
                        format: CountDownTimerFormat.minutesSeconds,
                        duration: brewingDuration,
                        startTime: widget.startTime,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Time until drinkable
                    TimerFrame(
                      description: 'Time until tea is cooled off',
                      timer: TimerBasic(
                        format: CountDownTimerFormat.minutesSeconds,
                        duration: coolOffDuration,
                        durationAdded: brewingDuration,
                        startTime: widget.startTime,
                      ),
                    ),

                    const SizedBox(height: 30),

                    CupertinoButton(
                      color: ColorManager.alertColor,
                      onPressed: () {
                        AlarmManager.cancelAlarms("both");
                        Navigator.pop(context); // Popping is the only way I have found to interrupt the "TimerCountdown"
                        // Navigator.push(context,
                        //   MaterialPageRoute(builder: (context) => const Home()));
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.lightColor,
                        )
                      )
                    )
                  ]
                )
              ),
            ],
          ),
        ),
      );
  }
}