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
}