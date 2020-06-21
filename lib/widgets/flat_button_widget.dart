import 'package:flutter/material.dart';

class FlatButtonWidget extends StatelessWidget {
  const FlatButtonWidget({
    this.text,
    this.fun,
  });

  final String text;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: FlatButton(
        color: Colors.green,
        child: Text(
          text,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        onPressed: fun,
      ),
    );
  }
}