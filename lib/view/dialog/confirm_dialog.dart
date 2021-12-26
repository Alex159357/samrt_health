import 'package:flutter/material.dart';


class ConfirmDialog {
  final String okText;
  final String cancelText;
  final BuildContext context;

  ConfirmDialog(
      {required this.okText,
      required this.cancelText,
        required this.context
      });

  Widget get _okButton =>
      ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(okText));

  Widget get _cancelButton => ElevatedButton(
      onPressed: () => Navigator.of(context).pop(), child: Text(cancelText));

  Widget get _getDialog =>  AlertDialog(
  title: Text("My title"),
  content: Text("This is my message."),
  actions: [_okButton, _cancelButton],
  );

  Future<dynamic> show() async{
    return  showDialog(
      context: context,
      builder: (BuildContext context) {
        return _getDialog;
      },
    );
  }


}
