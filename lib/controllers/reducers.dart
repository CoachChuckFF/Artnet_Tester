import 'package:artnet_tester/models/action.dart';
import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/models/network_settings.dart';
import 'package:artnet_tester/models/packet.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    packets: packetReducer(state.packets, action),
    networkSettings: networkSettingsReducer(state.networkSettings, action),
    count: countReducer(state.count, action)
  );
}

bool loadingReducer(bool state, action) {
  return false;
}

List<Packet> packetReducer(List<Packet> state, action){
  if(!(action is ArtnetAction)) return state;
  ArtnetAction act = action;

  switch(act.action){
    case ArtnetActions.sendPacket:
      tron.sendPacket(act.packet.artnetPacket.udpPacket);
      return new List<Packet>.from(state)..add(act.packet);
    break;
    case ArtnetActions.addPacket:
      return new List<Packet>.from(state)..add(act.packet);
    break;
    case ArtnetActions.deletePacket:
      return new List<Packet>.from(state)..remove(act.packet);
    break;  
    case ArtnetActions.clearPacket:
      return const [];
    break;
    default:
    break;
  }

  return state;
}

NetworkSettings networkSettingsReducer(NetworkSettings state, action){
  if(!(action is SettingAction)) return state;
  SettingAction act = action;

  switch(act.action){
    case SettingActions.setOutgoingIp:
      tron.outgoingIp = action.setting.ipAddress;
      return state.copyWith(ipAddress: action.setting.ipAddress);
    case SettingActions.setOutgoingPort:
      tron.outgoingPort = action.setting.port;
      return state.copyWith(port: action.setting.port);
    break;
    default:
    break;
  }

  return state;
}

int countReducer(int state, action){
  if(!(action is ArtnetAction)) return state;
  ArtnetAction act = action;

  switch(act.action){
    case ArtnetActions.sendPacket:
      state++;
    break;
    case ArtnetActions.addPacket:
      state++;
    break;
    case ArtnetActions.deletePacket:
      state--;
    break;
    case ArtnetActions.clearPacket:
      state = 0;
    break;
    default:
    break;
  }

  return state;
}