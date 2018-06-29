import 'dart:io';
import 'dart:async';
import 'package:validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:d_artnet/d_artnet.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:artnet_tester/models/app_state.dart';
import 'package:artnet_tester/models/network_settings.dart';
import 'package:artnet_tester/models/packet.dart';

import 'package:artnet_tester/views/main_screen.dart';
import 'package:artnet_tester/views/network_settings_screen.dart';

import 'package:artnet_tester/controllers/actions.dart';
import 'package:artnet_tester/controllers/reducers.dart';
import 'package:artnet_tester/controllers/udp_server.dart';

final UdpServerController server = new UdpServerController();

class UdpServerController{
  static const String broadcast = "255.255.255.255";
  static const int artnetPort = 6454;

  bool _connected = false;

  RawDatagramSocket _socket;
  Store _store;
  InternetAddress _ownIp = InternetAddress.anyIPv4;
  String _outgoingIp = broadcast;
  int _outgoingPort = artnetPort;
  int _uuid = 0;

  UdpServerController([String ip, int port, Store store]){
    if(ip != null) this.outgoingIp = ip;
    if(port != null) this.outgoingPort = port;
    if(store != null) this._store = store;
    RawDatagramSocket.bind(InternetAddress.anyIPv4, artnetPort).then((RawDatagramSocket socket){
      this._socket = socket;
      this._uuid = generateUUID32(3);
      print('UDP ready to receive');
      print('${socket.address.address}:${socket.port} - ${this._uuid}');
      this._connected = true;
      this._socket.broadcastEnabled = true;
      this._socket.listen(_handlePacket);

      //Kick off Timers!
      sendPacket(ArtnetBeepBeepPacket(this._uuid).udpPacket, broadcast, artnetPort);
      new Timer(Duration(seconds: 3), _tick);
      new Timer(Duration(seconds: 9), _beep);
    });
  }

  void setStore(Store store){
    this._store = store;
  }

  String get outgoingIp => this._outgoingIp;
  set outgoingIp(String value) => this._outgoingIp = (isIP(value)) ? value : broadcast;

  int get outgoingPort => this._outgoingPort;
  set outgoingPort(int value) => this._outgoingPort = (value < 0) ? artnetPort : value;

  void _handlePacket(RawSocketEvent e){
    Datagram gram = _socket.receive();
    if (gram == null) return;

    if(!checkArtnetPacket(gram.data)) return;

    if(getOpCode(gram.data) ==  ArtnetBeepBeepPacket.opCode){
      var packet = ArtnetBeepBeepPacket(null, gram.data);
      if(packet.uuid == this._uuid){
        this._ownIp = gram.address;
      }
    }

    switch(getOpCode(gram.data)){
      case ArtnetPollPacket.opCode:
        var packet = ArtnetPollPacket(gram.data);
      break;
    }

    if(this._ownIp == gram.address) return;

    if(this._store != null){
      this._store.dispatch(Actions.messageRecived);
    } else {
      print("Error: Null store");
      return;
    }

  }

  void sendPacket(List<int> packet,[String ip, int port]){
    String ipToSend = (ip == null) ? this._outgoingIp : ip;
    int portToSend = (port == null) ? this._outgoingPort : port; 

    if(!isIP(ipToSend)) return;

    if(_connected){
      _socket.send(packet, InternetAddress(ipToSend), portToSend);
    }
  }

  void _tick(){
    ArtnetPollPacket packet = ArtnetPollPacket();

    sendPacket(packet.udpPacket, broadcast, artnetPort);
    print("tick");
    new Timer(Duration(seconds: 3), _tick);
  }

  void _beep(){
    ArtnetBeepBeepPacket packet = ArtnetBeepBeepPacket(this._uuid);

    sendPacket(packet.udpPacket, broadcast, artnetPort);
    print("beep");
    new Timer(Duration(seconds: 9), _beep);
  }
}
