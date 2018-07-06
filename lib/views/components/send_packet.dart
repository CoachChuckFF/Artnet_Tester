import 'package:flutter/material.dart';
import 'package:artnet_tester/views/themes.dart';

class SendPacket extends StatelessWidget {
  final onTap;

  SendPacket(this.onTap);

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.deepPurpleAccent
      ),
      child: new FlatButton.icon(
        label: new Padding(
          padding: EdgeInsets.symmetric(
            vertical: 21.0
          ),
          child: new Text(
              "   Send Packet",
              textAlign: TextAlign.center,
              style: ButtonStyle,
          ),
        ), 
        icon: const Icon(
          Icons.send,
          color: Colors.white,
          size: 55.0,
          ),
        onPressed: onTap,
      ),
    );
  }
}