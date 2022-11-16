import 'package:xcards_admin_app/models/device/device_status.dart';
import 'package:xcards_admin_app/models/device/device_type.dart';

class Device {
  String id;
  DeviceStatus status;
  DeviceType type;
  String? userId;
  int? activationDate;

  Device(this.id, this.status, this.type, this.userId, this.activationDate);

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      json['id'],
      DeviceStatus.values[json['status']],
      DeviceType.values[json['type']],
      json['userId'],
      json['activationDate'],
    );
  }
}