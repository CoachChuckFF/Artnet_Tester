import 'package:flutter/material.dart';


import 'package:flutter_redux/flutter_redux.dart';


import 'package:artnet_tester/models/app_state.dart';

import 'package:artnet_tester/views/network_settings_screen.dart';
import 'package:artnet_tester/views/components/packet_list.dart';
import 'dart:io';
import 'dart:async';
import 'package:validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';

import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:artnet_tester/models/action.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/models/network_settings.dart';
import 'package:artnet_tester/models/packet.dart';

import 'package:artnet_tester/views/main_screen.dart';
import 'package:artnet_tester/views/network_settings_screen.dart';
import 'package:artnet_tester/views/components/packet_item.dart';
import 'package:artnet_tester/views/components/packet_count.dart';
import 'package:artnet_tester/views/components/send_packet.dart';
import 'package:artnet_tester/views/themes.dart';

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

import "package:flutter/material.dart";
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
