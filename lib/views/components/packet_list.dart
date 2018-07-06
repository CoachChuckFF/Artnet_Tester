import 'package:flutter/material.dart';
import 'package:artnet_tester/models/packet.dart';
import 'package:artnet_tester/views/components/packet_item.dart';


class PacketList extends StatelessWidget {
  final List<Packet> packets;
  final PacketActionCallback onTap;
  final PacketActionCallback onDoubleTap;
  final PacketActionCallback onLongPress;
  final ScrollController _scrollController = new ScrollController();

  PacketList({
    @required this.packets,
    @required this.onTap,
    @required this.onDoubleTap,
    @required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  ListView _buildListView() {
    return new ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: packets.length,
      itemBuilder: (BuildContext context, int index) {
        final packet = packets[index];

        return new PacketItem(
          packet: packet,
          onTap: this.onTap,
          onDoubleTap: this.onDoubleTap,
          onLongPressed: this.onLongPress,
        );
      },
    );
  }
}
