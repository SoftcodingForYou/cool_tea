import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_tea/countdown_timer.dart';
import 'package:cool_tea/user_settings.dart';
import 'package:cool_tea/duration_picker_frame.dart';
import 'package:cool_tea/durations.dart';
import 'package:cool_tea/colors.dart';
import 'package:cool_tea/timer_alarms.dart';
import 'package:cool_tea/defaults.dart';
import 'package:cool_tea/main.dart';


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


    bool lightMode              = SPHelper.sp.getBool("lightMode") ?? Defaults.lightMode;

    return CupertinoPageScaffold(
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Brewing duration timer
                  // ----------------------------------------------------
                  const DurationFrame(
                    description: "How long should your tea infuse?",
                    durationType: "brewingDuration",
                  ),

                  const SizedBox(height: 30),

                  // Cool-off duration timer
                  // ----------------------------------------------------
                  const DurationFrame(
                    description: "How long should your tea cool off after brewing?",
                    durationType: "coolOffDuration",
                  ),

                  const SizedBox(height: 45),

                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    decoration: BoxDecoration(
                      color: ColorManager.alertColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.alertColor.withAlpha(200),
                          blurRadius: 15,
                          offset: const Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      color: Colors.transparent,
                      onPressed: () {
                        saveTimers();

                        DateTime startTime = DateTime.now();
                        AlarmManager.setAlarm("brewing", startTime,
                          Durations.brewingDuration);
                        if (Durations.coolOffDuration > 0) {
                          AlarmManager.setAlarm("cooling", startTime,
                            Durations.coolOffDuration + Durations.brewingDuration);
                        }
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CountdownTimer(startTime: startTime)));
                      },
                      child: Text(
                        "Start",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.lightColor,
                        )
                      )
                    ),
                  ),

                  const SizedBox(height: 45),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(15), child: Container(
                        decoration: BoxDecoration(
                          color: ColorManager.alertColor,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.alertColor.withAlpha(200),
                              blurRadius: 15,
                              offset: const Offset(0, 0), // Shadow position
                            ),
                          ],
                        ),
                        child: CupertinoButton(
                          padding: const EdgeInsets.all(5),
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          color: Colors.transparent,
                          onPressed: () {
                            showInfoPopup(context);
                          },
                          child: Icon(
                            Icons.question_mark_rounded,
                            color: ColorManager.lightColor,
                          )
                        ),
                      ),),
                      const Spacer(),
                      Text("Dark mode",
                        style: TextStyle(
                          color: lightMode? ColorManager.alertColor : ColorManager.lightColor
                        ),
                      ),
                      CupertinoSwitch(
                        value: !lightMode,
                        activeColor: ColorManager.alertColor,
                        onChanged: (bool? value) {
                          setState(() {
                            switchTheme(lightMode);
                            lightMode = value ?? false;
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const MyApp()));
                          });
                        },
                      ),
                    ]
                  ),
                ]
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


  void switchTheme(bool lightMode) async {
    if (lightMode) {
      await SPHelper.sp.saveBool("lightMode", false);
    } else {
      await SPHelper.sp.saveBool("lightMode", true);
    }
  }


  void showInfoPopup(BuildContext context) {

    String infoText = """
... Yes.

As far as I know, this is the only app that actually reminds you to DRINK your tea after letting it cool off.

How many times have you forgotten about your tea once it was brewed, eh?

Tea is cool, but too cool is not cool!"
    """;

    showCupertinoModalPopup<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text("Yet another tea timer?"),
        content: Text(infoText),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'OK');
            },
            child: const Text("I'm cool with that"),
          ),
        ],
      )
    );
  }

}