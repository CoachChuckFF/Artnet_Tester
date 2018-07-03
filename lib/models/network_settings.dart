import 'package:meta/meta.dart';

@immutable
class NetworkSettings {
  static const broadcastIpAddress = "255.255.255.255";
  static const artnetPort = 6454;
  static const ipLength = 4;

  final String ipAddress;
  final int port;

  const NetworkSettings({this.ipAddress = broadcastIpAddress, this.port = artnetPort}); 
  
  NetworkSettings copyWith({
    String ipAddress,
    int port,
    }) {
    return new NetworkSettings(
      ipAddress: ipAddress ?? this.ipAddress,
      port: port ?? this.port,
    );
  }

  List<int> get ipIntArray {
    final RegExp ipExpression = new RegExp(r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
    if (!ipExpression.hasMatch(this.ipAddress)) return;
    var ipString = this.ipAddress.split(".");
    if(ipString.length != 4) return [255, 255, 255, 255];
    List<int> ipInt = new List<int>(4);
    ipInt[3] = int.parse(ipString[0]);
    ipInt[2] = int.parse(ipString[1]);
    ipInt[1] = int.parse(ipString[2]);
    ipInt[0] = int.parse(ipString[3]);
    return ipInt;
  }

}