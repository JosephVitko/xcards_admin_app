import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:xcards_admin_app/context/auth.dart';

import '../models/device/device.dart';
import '../models/device/device_status.dart';
import '../services/api_service.dart';

class DeviceManager {

  static Future<Device> getDevice(AuthProvider authProvider, String id) async {

    try {
      String? token = await authProvider.getAccessToken();
      Device device = await ApiService.getDevice(token!, id);
      OneContext().showSnackBar(
          builder: (_) => SnackBar(content: Text('Retrieved device with id: ${device.id}, status: ${device.status}, type: ${device.type}'))
      );
      return device;
    }
    catch (e) {
      OneContext().showSnackBar(
          builder: (_) => const SnackBar(content: Text('Failed to retrieve device.'))
      );
      throw e;
    }
  }

  static Future<Device> createDevice(AuthProvider authProvider, DeviceType type) async {
    try {
      String? token = await authProvider.getAccessToken();
      Device device = await ApiService.createDevice(token!, type);
      OneContext().showSnackBar(
          builder: (_) => SnackBar(content: Text('Created device with id: ${device.id}, status: ${device.status}, type: ${device.type}'))
      );
      return device;
    }
    catch (e) {
      OneContext().showSnackBar(
          builder: (_) => const SnackBar(content: Text('Failed to create device.'))
      );
      throw e;
    }
  }

}