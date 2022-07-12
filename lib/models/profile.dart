import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rhrs_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String userName;
  final String email;
  final String phone;
  final String age;
  final String gender;
  final int amount;
  final String profilePhoto;
  Profile myProfile;

  Profile(
      {this.id,
      this.age,
      this.gender,
      this.email,
      this.phone,
      this.userName,
      this.amount,
      this.profilePhoto});

  Future<void> fetchProfileInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, dynamic>;
    String token = extractedData['token'];
    final url = Uri.parse(onlineApi + "api/profile/show");

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': "Bearer " + token
    };
    try {
      final response = await http.get(url, headers: headers);
      final profileData = json.decode(response.body);
      print(response.body);
      myProfile = Profile(
          id: profileData['profile']['id_user'],
          gender: profileData['profile']['gender'],
          phone: profileData['profile']['phone'],
          age: profileData['profile']['age'],
          profilePhoto: profileData['profile']['path_photo'],
          amount: profileData['user']['amount'],
          email: profileData['user']['email'],
          userName: profileData['user']['name']);
    } catch (e) {
      print(e);
      myProfile = Profile();
    }
  }
}
