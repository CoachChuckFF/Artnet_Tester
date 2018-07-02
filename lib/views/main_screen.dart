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

import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';


class MainScreen extends StatefulWidget {
  @override
  createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  //data
  final _io_packets = <List<int>>[];

  //aesthetics
  final _font = const TextStyle(color: Colors.deepOrange,
                                fontSize: 18.0,
                                fontFamily: 'Roboto');
  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Artnet Packets'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.settings), onPressed: _pushNetworkSettings),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("Artnet Packets Received"),
            new StoreConnector<AppState, String>(
              converter: (store) => store.state.count.toString(),
              builder: (context, count) {
                return new Text(
                  count,
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            new SizedBox(
              width: 200.0,
              height: 500.0,
              child: new StoreConnector<AppState, List<Packet>>(
                converter: (store) => store.state.packets,
                builder: (context, packets) {
                  return new PacketList(
                    packets: packets
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pushNetworkSettings() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return NetworkSettingsScreen();
        },
      ),
    );
  }

}