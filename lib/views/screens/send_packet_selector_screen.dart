import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:artnet_tester/models/action.dart';
import 'package:artnet_tester/models/packet.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/controllers/udp_server.dart';
import 'package:artnet_tester/views/components/packet_button.dart';
import 'package:artnet_tester/views/screens/data_packet_builder_screen.dart';
import 'package:artnet_tester/views/screens/raw_hex_packet_builder_screen.dart';


class SendPacketSelectorScreen extends StatelessWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SendPacketSelectorScreen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold (
      key: _scaffoldKey,
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
              onTap: () {
                StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, new ArtnetPollPacket(), tron.outgoingIp, tron.outgoingPort)));
                showInSnackBar("Poll packet sent!");
              },
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
              onTap: () {
                StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.sendPacket, new Packet(false, new ArtnetSyncPacket(), tron.outgoingIp, tron.outgoingPort)));
                showInSnackBar("Sync packet sent!");
              },
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
              onTap: () => _pushRawHexPacketPage(context),
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value)
    ));
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

void _pushRawHexPacketPage(BuildContext context){
    Navigator.of(context).push(
    new MaterialPageRoute(
      builder: (context) {
        return RawHexPacketBuilderScreen();
      },
    ),
  );
}

