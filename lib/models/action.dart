import './packet.dart';

class ArtnetAction {
  final dynamic action; 
  final Packet packet;

  ArtnetAction(this.action, this.packet);

}

enum Actions {
  addPacket,
  sendPacket,
  clearPacket,
}