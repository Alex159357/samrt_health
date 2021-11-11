

import 'package:flutter/material.dart';

class TestNotify extends StatefulWidget {
  const TestNotify({Key? key}) : super(key: key);

  @override
  _TestNotifyState createState() => _TestNotifyState();
}

class _TestNotifyState extends State<TestNotify> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Test notyfy"),),);
  }
}
