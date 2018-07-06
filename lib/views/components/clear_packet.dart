import 'package:flutter/material.dart';
import 'package:artnet_tester/views/themes.dart';


class ClearPacket extends StatelessWidget {
  final onTap;

  ClearPacket(this.onTap);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.deepOrange
      ),
      child: new FlatButton.icon(
        label: new Padding(
          padding: EdgeInsets.symmetric(
            vertical: 21.0
          ),
          child: new Text(
              "Clear",
              textAlign: TextAlign.center,
              style: ButtonStyle,
          ),
        ), 
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 55.0,
          ),
        onPressed: onTap,
      ),
    );
  }
}