import 'package:flutter/cupertino.dart';
import 'package:cool_tea/home.dart';
import 'package:cool_tea/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:cool_tea/defaults.dart';
import 'package:cool_tea/colors.dart';
import 'package:alarm/alarm.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init(showDebugLogs: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<bool>(
      future: startupSequence(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          var data = snapshot.data;

          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (data) {

            bool lightMode = SPHelper.sp.getBool("lightMode") ?? Defaults.lightMode;

            return CupertinoApp(
              debugShowCheckedModeBanner: false,
              theme: CupertinoThemeData(
                brightness: lightMode? Brightness.light : Brightness.dark,
                textTheme: CupertinoTextThemeData(
                  primaryColor: ColorManager.lightColor,
                  textStyle: TextStyle(
                    fontSize: 18,
                    color: ColorManager.lightColor
                  ),
                  actionTextStyle:  TextStyle(
                    color: ColorManager.lightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                )
              ),
              home: const Home(),
            );
          } else if (!data) {
              return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("An error was encountered."),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Future<bool> startupSequence() async {
    bool gotSettings        = false;
    await SPHelper.sp.initSharedPreferences();

    int brewingDuration     = SPHelper.sp.getInt("brewingDuration")     ?? Defaults.brewingDuration;
    int coolOffDuration     = SPHelper.sp.getInt("coolOffDuration")     ?? Defaults.coolOffDuration;
    int minDuration         = SPHelper.sp.getInt("minDuration")         ?? Defaults.minDuration;
    int maxCoolOffDuration  = SPHelper.sp.getInt("maxCoolOffDuration")  ?? Defaults.maxCoolOffDuration;
    int maxBrewingDuration  = SPHelper.sp.getInt("maxBrewingDuration")  ?? Defaults.maxBrewingDuration;
    bool lightMode          = SPHelper.sp.getBool("lightMode")          ?? Defaults.lightMode;

    await SPHelper.sp.saveInt("brewingDuration",    brewingDuration);
    await SPHelper.sp.saveInt("coolOffDuration",    coolOffDuration);
    await SPHelper.sp.saveInt("minDuration",        minDuration);
    await SPHelper.sp.saveInt("maxCoolOffDuration", maxCoolOffDuration);
    await SPHelper.sp.saveInt("maxBrewingDuration", maxBrewingDuration);
    await SPHelper.sp.saveBool("lightMode", lightMode);

    gotSettings = true;
    return gotSettings;
  }

}
