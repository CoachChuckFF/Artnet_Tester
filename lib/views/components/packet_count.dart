import 'package:flutter/material.dart';
import 'package:artnet_tester/views/themes.dart';

class PacketCount extends StatelessWidget {
  final String count;

  PacketCount({
    @required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.deepPurpleAccent
      ),
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(10.0),
            child: new Text(
              "Art-Net 4 Packet Count",
              textAlign: TextAlign.center,
              style: TitleStyle,
            )
          ),
          new Padding(
            padding: new EdgeInsets.only(
              bottom: 10.0
            ),
            child: new Text(
              this.count,
              textAlign: TextAlign.center,
              style: SubTitleStyle,
            )
          ),
        ],
      ),
    );
  }
}