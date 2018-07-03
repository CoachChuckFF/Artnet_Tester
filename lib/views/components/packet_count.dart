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
import 'package:artnet_tester/views/themes.dart';

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

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