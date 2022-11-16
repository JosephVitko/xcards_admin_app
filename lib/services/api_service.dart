import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xcards_admin_app/models/device/device_status.dart';

import '../config/api_config.dart';
import '../models/device/device.dart';

class ApiService {

  static Future<Device> getDevice(String bearerToken, String id) async {
    final String url = '${ApiConfig.baseUrl}/device/?id=$id';

    final http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      print(json);
      return Device.fromJson(json);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to get device.');
    }
  }

  static Future<Device> createDevice(String bearerToken, DeviceType type) async {
    final String url = '${ApiConfig.baseUrl}/device/';

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'type': type.index,
      })
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      print(json);
      return Device.fromJson(json);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to create device.');
    }
  }
}