import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rhrs_app/constants.dart';
import 'package:rhrs_app/models/facility.dart';
import 'package:http/http.dart' as http;
import 'package:rhrs_app/models/facility_photo.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Facilities extends ChangeNotifier {
  String nextUrl;
  List<Facility> _facilities = [
    /*Facility(
        id: '1',
        name: 'anas\'s resort',
        location: 'Damascus',
        description: 'really nice view with such a beautiful infrastructure.',
        cost: 70,
        facilityImages: [
          AssetImage('assets/images/facility.jpg'),
        ],
        numberOfGuets: 4,
        numberOfRooms: 5,
        facilityType: FacilityType.RESORT,
        rate: 4),
    Facility(
        id: '2',
        name: 'ameer\'s resort',
        location: 'Latakia',
        description: 'really nice view with such a beautiful infrastructure.',
        cost: 85,
        facilityImages: [
          AssetImage('assets/images/facility.jpg'),
        ],
        numberOfGuets: 4,
        numberOfRooms: 5,
        facilityType: FacilityType.CHALET,
        rate: 5),*/
  ];

  List<Facility> savedFacilities = [];

  Future<void> fetchSavedFacilities() async {
    savedFacilities = [];
    final API = onlineApi + 'api/favorite/index';
    var url = Uri.parse(API);

    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      final response = await http.get(url, headers: headers);
      final extractedData = json.decode(response.body);
      print(extractedData['Data']);
      final data = (extractedData['Data'] as List)
          .map((data) => Facility(
                id: data['id'].toString(),
                name: data['name'],
                type: data['type'],
                description: data['description'],
                rate: data['rate'],
                cost: data['cost'],
                location: data['location'],
                hasCoffee: true,
                //data['coffee_machine'] == 0 ? false : true,
                hasCondition: true,
                //data['air_condition'] == 0 ? false : true,
                hasFridge: true,
                //data['fridge'] == 0 ? false : true,
                hasWifi: data['wifi'] == 0 ? false : true,
                hasTv: true,
                //data['tv'] == 0 ? false : true,
                facilityImages: List.from(data['photos']).length > 0 ?
                     (data['photos'] as List)
                        .map((photo) => FacilityPhoto(
                              photoId: photo['id'],
                              facilityId: photo['id_facility'],
                              photoPath: photo['path_photo']/* != null
                                  ? photo['path_photo']
                                  : 'https://trekbaron.com/wp-content/uploads/2020/07/types-of-resorts-July282020-1-min.jpg',*/
                            ))
                        .toList()
                    : [
                        FacilityPhoto(
                          photoId: 1,
                          photoPath:
                              'https://trekbaron.com/wp-content/uploads/2020/07/types-of-resorts-July282020-1-min.jpg',
                        )
                      ],
              ))
          .toList();
      savedFacilities.addAll(data);
      print(savedFacilities[0].facilityImages);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchNextMatched() async {
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final List<Facility> _loadedFacilities = [];

    try {
      final response = await http.get(Uri.parse(nextUrl), headers: headers);
      final extractedData = json.decode(response.body);
      print(response.body);
      final data = (extractedData['facilities'] as List)
          .map((data) => Facility(
                id: data['id'].toString(),
                name: data['name'],
                type: data['type'] == 'farmer' ? 'Resort' : data['type'],
                description: data['description'],
                rate: data['rate'],
                cost: data['cost'],
                location: data['location'],
                hasCoffee: true,
                //data['coffee_machine'] == 0 ? false : true,
                hasCondition: true,
                //data['air_condition'] == 0 ? false : true,
                hasFridge: true,
                //data['fridge'] == 0 ? false : true,
                hasWifi: data['wifi'] == 0 ? false : true,
                hasTv: true,
                //data['tv'] == 0 ? false : true,
                facilityImages: (data['photos'] as List)
                    .map((photo) => FacilityPhoto(
                        photoId: photo['id'],
                        facilityId: photo['id_facility'],
                        photoPath: photo['path_photo']))
                    .toList(),
              ))
          .toList();
      nextUrl = extractedData['url_next_page'];
      _loadedFacilities.addAll(data);
      print('\ntotal :  ${extractedData['total_items']}\n');
      //print('length : ${_facilities.length}');
      _facilities.addAll(_loadedFacilities);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<void> fetchMatchedFacilities(
      {String startDate,
      String endDate,
      int minCost,
      int maxCost,
      int rate,
      String propertyType}) async {
    double min = minCost.toDouble();
    double max = maxCost.toDouble();
    print(startDate);
    print(endDate);
    var queryParameters = {
      "type[]": propertyType,
      //"type": propertyType,
      "cost1": '$minCost',
      "cost2": '$maxCost',
      "rate": '$rate',
      "start_date": "$startDate",
      "end_date": "$endDate",
    };
    //DateTime
    print(queryParameters);
    print(minCost);
    print(maxCost);
    print(rate);
    print('anas');
    Map<String, String> headers = {
      // 'Content-Type': 'multipart/form-data',
      //'X-Requested-With': ' XMLHttpRequest ',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final uri = Uri.http('laravelapimk.atwebpages.com',
        '/public/api/facilities/search', queryParameters);
    /*final uri = Uri.http(
        '192.168.43.181:8000', '/api/facilities/search', queryParameters);*/
    final List<Facility> _loadedFacilities = [];

    try {
      print('anas3');
      final response = await http.get(uri, headers: headers);
      final extractedData = json.decode(response.body);
      print(response.body);
      final data = (extractedData['facilities'] as List)
          .map((data) => Facility(
                id: data['id'].toString(),
                name: data['name'],
                type: data['type'] == 'farmer' ? 'Resort' : data['type'],
                description: data['description'],
                rate: data['rate'],
                cost: data['cost'],
                location: data['location'],
                hasCoffee: true,
                //data['coffee_machine'] == 0 ? false : true,
                hasCondition: true,
                //data['air_condition'] == 0 ? false : true,
                hasFridge: true,
                //data['fridge'] == 0 ? false : true,
                hasWifi: data['wifi'] == 0 ? false : true,
                hasTv: true,
                //data['tv'] == 0 ? false : true,
                facilityImages: (data['photos'] as List)
                    .map((photo) => FacilityPhoto(
                        photoId: photo['id'],
                        facilityId: photo['id_facility'],
                        photoPath: photo['path_photo']))
                    .toList(),
              ))
          .toList();
      nextUrl = extractedData['url_next_page'];
      print('next url : $nextUrl');
      print('first total :  ${extractedData['total_items']}\n');
      _loadedFacilities.addAll(data);
      _facilities = _loadedFacilities;
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Facility findById(String id) {
    return _facilities.firstWhere((facility) => facility.id == id);
  }

  List<Facility> get facilities => _facilities;
}
