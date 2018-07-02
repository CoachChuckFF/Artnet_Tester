import 'package:meta/meta.dart';
import 'package:d_artnet/d_artnet.dart';

@immutable
class Packet {
  final bool receivedItem;
  final ArtnetPacket artnetPacket;
  int uuid;

  //static
  static int id = 0;

  Packet(this.receivedItem, this.artnetPacket){
    this.uuid = id++;
  }

  @override
  int get hashCode =>
      receivedItem.hashCode ^ artnetPacket.hashCode ^ uuid.hashCode;

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Packet &&
          runtimeType == other.runtimeType &&
          receivedItem == other.receivedItem &&
          artnetPacket == other.artnetPacket &&
          uuid == other.uuid;

  @override
  String toString() {
    return this.artnetPacket.toString() + this.artnetPacket.toHexString();
  }
}
