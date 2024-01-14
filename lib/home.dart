import 'package:flutter/cupertino.dart';
import 'package:cool_tea/setup.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: SafeArea(
          minimum: EdgeInsets.all(20),
          child: Setup()
        ),
      );
  }
}