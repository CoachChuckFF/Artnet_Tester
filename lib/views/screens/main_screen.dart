import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/models/action.dart';
import 'package:artnet_tester/models/packet.dart';
import 'package:artnet_tester/views/components/packet_count.dart';
import 'package:artnet_tester/views/components/clear_packet.dart';
import 'package:artnet_tester/views/components/send_packet.dart';
import 'package:artnet_tester/views/components/packet_list.dart';
import 'package:artnet_tester/views/screens/packet_screen.dart';
import 'package:artnet_tester/views/screens/network_settings_screen.dart';
import 'package:artnet_tester/views/screens/send_packet_selector_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold (

      appBar: new AppBar(
        title: new Text('Artnet Packets'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.settings), onPressed: _pushNetworkSettings),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          new StoreConnector<AppState, String>(
            converter: (store) => store.state.count.toString(),
            builder: (context, count) {
              return new PacketCount(
                count: count
              );
            },
          ),
          new Expanded(
            child: new StoreConnector<AppState, List<Packet>>(
              converter: (store) => store.state.packets,
              builder: (context, packets) {
                return new PacketList(
                  packets: packets,
                  onTap: _pushPacketPage,
                  onDoubleTap: _deletePacket,
                  onLongPress: _clearAllPackets,
                );
              },
            ),
          ),
          new Row(
            children: <Widget>[
              new ClearPacket(_clearAllPackets),
              new Expanded(
                child: new SendPacket(_pushSendPacketPage),
              ),
            ],
          )
        ],
      )
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

  void _pushSendPacketPage() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return SendPacketSelectorScreen();
        },
      ),
    );
  }

  void _pushPacketPage(Packet packet){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return PacketScreen(packet: packet);
        },
      ),
    );
  }

  void _deletePacket(Packet packet){
    StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.deletePacket, packet));
  }

  void _clearAllPackets([Packet packet]){
    StoreProvider.of<AppState>(context).dispatch(new ArtnetAction(ArtnetActions.clearPacket, null));
  }

}
