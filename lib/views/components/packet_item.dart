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

class PacketItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Packet packet;

  PacketItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.packet,
  });

  @override
  Widget build(BuildContext context) {
    return new Text(packet.uuid.toString() + " " + ((packet.receivedItem) ? "<==" : "==>"));
    return new Dismissible(
      key: key,
      onDismissed: onDismissed,
      child: new ListTile(
        onTap: onTap,
        title: new Text(
          packet.uuid.toString() + " " + ((packet.receivedItem) ? "<==" : "==>"),
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: new Text(
          opCodeToString(getOpCode(packet.artnetPacket.udpPacket)),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subhead,
        ),
      ),
    );
  }
}
