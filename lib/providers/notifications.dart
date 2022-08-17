import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../models/notification.dart';

class Notifications extends ChangeNotifier {
  List<Notification1> notifications = [];

  Future<void> fetchNotifications() async {
    notifications = [];
    print('get');
    //final url = localApi + 'api/user/notifications';
    final queryParameters = {
      "type": "All" /*, "num_values": 50*/
    };
    final uri =
        Uri.http(apiWithParams, '/api/user/notifications', queryParameters);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('token'));
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    String token = extractedData['token'];
    print(token);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer" + " " + token
    };

    try {
      final response = await http.get(uri, headers: headers);
      final extractedData = await json.decode(response.body);
      print(extractedData);
      final data = (extractedData['Notifications'] as List)
          .map((data) => Notification1(
              title: data['data']['header'],
              content: data['data']['body'],
              creationDate: data['data']['created_at'],
              notifyType: data['data']['Notify_type']))
          .toList();
      notifications.addAll(data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
