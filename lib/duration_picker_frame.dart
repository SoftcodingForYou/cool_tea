import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_tea/durations.dart';
import 'package:wheel_chooser/wheel_chooser.dart';
import 'package:cool_tea/colors.dart';


class DurationFrame extends StatefulWidget {
  final String description;
  final String durationType;

  const DurationFrame({
    required this.description,
    required this.durationType,
    Key? key,
  }) : super(key: key);

  @override
  State<DurationFrame> createState() => _DurationFrameState();

}

class _DurationFrameState extends State<DurationFrame> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    int currentDuration = Durations.brewingDuration;
    int minDuration     = Durations.minDuration;
    int maxDuration     = Durations.maxBrewingDuration;
    if (widget.description == "brewingDuration") {
      minDuration       = Durations.minDuration;
      currentDuration   = Durations.brewingDuration;
      maxDuration       = Durations.maxBrewingDuration;
    } else if (widget.durationType == "coolOffDuration") {
      minDuration       = 0;
      currentDuration   = Durations.coolOffDuration;
      maxDuration       = Durations.maxCoolOffDuration;
    }
    print(currentDuration);

    FixedExtentScrollController controllerWC  = FixedExtentScrollController(initialItem: currentDuration - minDuration);
    controllerWC.jumpToItem(currentDuration - minDuration);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(
        15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.backgroundStrong,
        border: Border.all(
          width: 2,
          color: Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30), 
            child: Text(
              widget.description,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 0,
                color: ColorManager.lightColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // CupertinoButton(
              //   onPressed: () {
              //     if (currentDuration > minDuration) {
              //       setState(() {
              //         currentDuration = currentDuration - 1;
              //         controllerWC.jumpToItem(currentDuration - 1);
              //         if (widget.durationType == "brewingDuration") {
              //           Durations.brewingDuration = currentDuration;
              //         } else if (widget.durationType == "coolOffDuration") {
              //           Durations.coolOffDuration = currentDuration;
              //         }
              //       });
              //     }
              //   },
              //   child: Icon(
              //     Icons.arrow_left_rounded,
              //     color: ColorManager.lightColor,
              //   )
              // ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.5,
                child: WheelChooser.integer(
                  onValueChanged: (i) {
                    setState(() {
                      currentDuration = i;
                      if (widget.durationType == "brewingDuration") {
                        Durations.brewingDuration = currentDuration;
                      } else if (widget.durationType == "coolOffDuration") {
                        Durations.coolOffDuration = currentDuration;
                      }
                    });
                  },
                  magnification: 1.2,
                  squeeze: 0.75,
                  perspective: 0.01,
                  maxValue: maxDuration,
                  minValue: minDuration,
                  controller: controllerWC,
                  horizontal: true,
                  unSelectTextStyle: null,
                  selectTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              // CupertinoButton(
              //   onPressed: () {
              //     if (currentDuration < maxDuration) {
              //       setState(() {
              //         currentDuration = currentDuration + 1;
              //         controllerWC.jumpToItem(currentDuration - 1);
              //         if (widget.durationType == "brewingDuration") {
              //           Durations.brewingDuration = currentDuration;
              //         } else if (widget.durationType == "coolOffDuration") {
              //           Durations.coolOffDuration = currentDuration;
              //         }
              //       });
              //     }
              //   },
              //   child: Icon(
              //     Icons.arrow_right_rounded,
              //     color: ColorManager.lightColor,
              //   )
              // ),
            ]
          ),
          const Text("minutes"),
        ],
      ),
    );
  }

}