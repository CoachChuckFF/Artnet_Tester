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
import 'package:artnet_tester/views/data_packet_builder_screen.dart';
import 'package:artnet_tester/views/components/packet_item.dart';
import 'package:artnet_tester/views/components/packet_count.dart';
import 'package:artnet_tester/views/components/send_packet.dart';
import 'package:artnet_tester/views/components/packet_button.dart';
import 'package:artnet_tester/views/themes.dart';

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';


class SendPacketSelectorScreen extends StatelessWidget{

  SendPacketSelectorScreen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text("Packet to Send"),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new PacketButton(
              type: "Data",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Poll",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Poll Reply",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Address",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Ip Prog",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Ip Prog Reply",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Command",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Sync",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Firmware Master",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Firmware Reply",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
            new PacketButton(
              type: "Raw Hex",
              color: Colors.black,
              onTap: () => _pushDataPacketBuilder(context),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
                size: 55.0,
              ),
            ),
          ],
        )
      ),
    );
  }
}

void _pushDataPacketBuilder(BuildContext context){
  Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (context) {
        return DataPacketBuilderScreen();
      },
    ),
  );
}

