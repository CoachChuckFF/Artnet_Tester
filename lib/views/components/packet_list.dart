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

class PacketList extends StatelessWidget {
  final List<Packet> packets;

  PacketList({
    @required this.packets,
  });

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  ListView _buildListView() {
    return new ListView.builder(
      itemCount: packets.length,
      itemBuilder: (BuildContext context, int index) {
        final packet = packets[index];

        return new PacketItem(
          packet: packet,
          onDismissed: (direction) {
            _removePacket(context, packet);
          },
          //onTap: () => _onPacketTap(context, packet),
        );
      },
    );
  }

  void _removePacket(BuildContext context, Packet packet) {

    Scaffold.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 2),
        backgroundColor: Theme.of(context).backgroundColor,
        content: new Text(
          "Goodbye",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )));
  }
/*
  void _onPacketTap(BuildContext context, Packet packet) {
    Navigator
        .of(context)
        .push(new MaterialPageRoute(
          builder: (_) => new TodoDetails(id: todo.id),
        ))
        .then((removedTodo) {
      if (removedTodo != null) {
        Scaffold.of(context).showSnackBar(new SnackBar(
            key: ArchSampleKeys.snackbar,
            duration: new Duration(seconds: 2),
            backgroundColor: Theme.of(context).backgroundColor,
            content: new Text(
              ArchSampleLocalizations.of(context).todoDeleted(todo.task),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            action: new SnackBarAction(
              label: ArchSampleLocalizations.of(context).undo,
              onPressed: () {
                onUndoRemove(todo);
              },
            )));
      }
    });
  }*/
}
