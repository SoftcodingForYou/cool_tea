import 'package:flutter/material.dart';
import 'package:cool_tea/colors.dart';


class TimerFrame extends StatelessWidget {
  final String description;
  final Widget timer;

  const TimerFrame({
    required this.description,
    required this.timer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Text(
            description,
            style: TextStyle(
              fontSize: 20,
              letterSpacing: 0,
              color: ColorManager.lightColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          timer,
        ],
      ),
    );
  }
}