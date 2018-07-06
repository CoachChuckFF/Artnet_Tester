import 'package:flutter/material.dart';
import 'package:artnet_tester/views/themes.dart';

class PacketButton extends StatelessWidget {
  final onTap;
  final Icon icon;
  final String type;
  final Color color;

  PacketButton({
    this.onTap,
    this.icon,
    this.type,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      decoration: new BoxDecoration(
        color: color
      ),
      child: new FlatButton(
        child: new Padding(
          padding: EdgeInsets.symmetric(
            vertical: 21.0
          ),
          child: new Text(
              type,
              textAlign: TextAlign.left,
              style: ButtonStyle,
          ),
        ), 
        onPressed: onTap,
      ),
    );
  }
}