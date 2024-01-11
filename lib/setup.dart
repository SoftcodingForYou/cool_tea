import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drink_your_tea/countdown_timer.dart';
import 'package:drink_your_tea/user_settings.dart';
import 'package:drink_your_tea/duration_picker_frame.dart';
import 'package:drink_your_tea/durations.dart';
import 'package:drink_your_tea/colors.dart';


class Setup extends StatefulWidget {
  const Setup({super.key});

  @override
  State<Setup> createState() => _SetupState();
}

class _SetupState extends State<Setup> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    // TO-DO: Cancel all timers 

    return CupertinoPageScaffold(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Column(
                  children: [

                    // Brewing duration timer
                    // ----------------------------------------------------
                    const DurationFrame(
                      description: "How long should your tea infuse?",
                      durationType: "brewingDuration",
                    ),

                    const SizedBox(height: 60),

                    // Cool-off duration timer
                    // ----------------------------------------------------
                    const DurationFrame(
                      description: "How long should your tea cool off after brewing?",
                      durationType: "coolOffDuration",
                    ),

                    
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: CupertinoButton(
                        color: ColorManager.backgroundStrong,
                        onPressed: () {
                          saveTimers();
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const CountdownTimer()));
                        },
                        child: Text(
                          "Cick here to start brewing your tea",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorManager.lightColor,
                          )
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

  void saveTimers() async {
    await SPHelper.sp.saveInt("brewingDuration",    Durations.brewingDuration);
    await SPHelper.sp.saveInt("coolOffDuration",    Durations.coolOffDuration);
  }

}