import './packet.dart';
import './network_settings.dart';

class ArtnetAction {
  final dynamic action; 
  final Packet packet;

  ArtnetAction(this.action, this.packet);

}

class SettingAction {
  final dynamic action;
  final NetworkSettings setting;

  SettingAction(this.action, this.setting);
}

enum SettingActions {
  setOutgoingIp,
  setOutgoingPort,
}

enum ArtnetActions {
  addPacket,
  deletePacket,
  sendPacket,
  clearPacket,
}