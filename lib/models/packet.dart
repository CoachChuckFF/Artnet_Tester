import 'package:meta/meta.dart';
import 'package:d_artnet/d_artnet.dart';

@immutable
class Packet {
  final bool sendItem;
  final ArtnetPacket artnetPacket;
  int uuid;

  //static
  static int id = 0;

  Packet(this.sendItem, this.artnetPacket){
    this.uuid = id++;
  }

  @override
  int get hashCode =>
      sendItem.hashCode ^ artnetPacket.hashCode ^ uuid.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Packet &&
          runtimeType == other.runtimeType &&
          sendItem == other.sendItem &&
          artnetPacket == other.artnetPacket &&
          uuid == other.uuid;

  @override
  String toString() {
    return this.artnetPacket.toString() + this.artnetPacket.toHexString();
  }
}
