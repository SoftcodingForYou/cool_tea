import 'package:cool_tea/user_settings.dart';
import 'package:cool_tea/defaults.dart';

class Durations {
  static int brewingDuration     = SPHelper.sp.getInt("brewingduration")     ?? Defaults.brewingDuration;
  static int coolOffDuration     = SPHelper.sp.getInt("coolOffDuration")     ?? Defaults.coolOffDuration;
  static int minDuration         = SPHelper.sp.getInt("minDuration")         ?? Defaults.minDuration;
  static int maxCoolOffDuration  = SPHelper.sp.getInt("maxCoolOffDuration")  ?? Defaults.maxCoolOffDuration;
  static int maxBrewingDuration  = SPHelper.sp.getInt("maxBrewingDuration")  ?? Defaults.maxBrewingDuration;

}