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

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

typedef void PacketActionCallback(Packet packet);

class PacketItem extends StatelessWidget {
  final PacketActionCallback onTap;
  final PacketActionCallback onDoubleTap;
  final PacketActionCallback onLongPressed;
  final Packet packet;

  PacketItem({
    @required this.onTap,
    @required this.onDoubleTap,
    @required this.onLongPressed,
    @required this.packet,
  });

  GestureTapCallback _getHandler(PacketActionCallback callback) {
    return callback == null ? null : () => callback(packet);
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: _getHandler(onTap),
      onDoubleTap: _getHandler(onDoubleTap),
      onLongPress: _getHandler(onLongPressed),
      child: new Container(
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(
              color: Theme.of(context).dividerColor
            )
          )
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                packet.uuid.toString(),
                textAlign: TextAlign.center
              )
            ),
            new Expanded(
              flex: 2,
              child: new Text(
                packet.ipAddress.toString(),
                textAlign: TextAlign.center
              )
            ),
            new Expanded(
              child: new Text(
                packet.port.toString(),
                textAlign: TextAlign.center
              )
            ),
            new Expanded(
              child: new Text(
                opCodeToString(getOpCode(packet.artnetPacket.udpPacket)),
                textAlign: TextAlign.center
              )
            ),
            new Expanded(
              child: new Icon(
              ((packet.receivedItem) ? Icons.arrow_back_ios : Icons.arrow_forward_ios),
              color: ((packet.receivedItem) ? Colors.deepOrange : Colors.green),
              size: 55.0,
              ),
            ),
          ],
        )
      ),
    );
  }
}
