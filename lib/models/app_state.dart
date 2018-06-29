import 'package:meta/meta.dart';
import 'packet.dart';
import 'network_settings.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Packet> packets;
  final NetworkSettings networkSettings;
  final int count;

  AppState(
      {this.isLoading = false,
      this.packets = const [],
      this.networkSettings = const NetworkSettings(),
      this.count = 0});

  factory AppState.loading() => new AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<Packet> packets,
    NetworkSettings networkSettings,
    int count
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      packets: packets ?? this.packets,
      networkSettings: networkSettings ?? this.networkSettings,
      count: count ?? this.count
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      packets.hashCode ^
      networkSettings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          packets == other.packets &&
          networkSettings == other.networkSettings;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, packets: $packets, networkSettings: $networkSettings}';
  }

}