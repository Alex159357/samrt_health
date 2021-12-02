


import 'package:flutter/material.dart';

class BottomSheetAdd extends StatefulWidget {
  final bool ifOpen;
  const BottomSheetAdd({Key? key, required this.ifOpen}) : super(key: key);

  @override
  _BottomSheetAddState createState() => _BottomSheetAddState();
}

class _BottomSheetAddState extends State<BottomSheetAdd> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.ifOpen? null : 0,
      color: Colors.red,
      duration: Duration(milliseconds: 500),
    );
  }
}
