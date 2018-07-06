import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';
import 'package:artnet_tester/models/packet.dart';
import 'package:flutter/services.dart';


class PacketScreen extends StatelessWidget{
  final Packet packet;

  PacketScreen({
    @required this.packet
  });

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text("Packet: ${packet.uuid.toString()} - ${opCodeToString(getOpCode(packet.artnetPacket.udpPacket))}\n${packet.ipAddress}:${packet.port.toString()}"),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new Text(
              packet.artnetPacket.toString()
            ),
            new GestureDetector(
              child: new CopyHexToolTip(
                text: packet.artnetPacket.toHexString()
              ),
            ),
          ],
        )
      ),
    );
  }

}

class CopyHexToolTip extends StatelessWidget {

  final String text;

  CopyHexToolTip({this.text});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Tooltip(preferBelow: false,
          message: "Copy Hex Packet", child: new Text(text)),
      onTap: () {
        Clipboard.setData(new ClipboardData(text: text));
      },
    );
  }
}
