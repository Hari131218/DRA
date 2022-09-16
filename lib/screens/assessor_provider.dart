import 'dart:convert';

import 'package:dra_project/models/assessment_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/app_constants.dart';
import '../models/homeowner_api.dart';

class AssessorProvider extends ChangeNotifier {
  bool _isLoading = false;
  late SharedPreferences localStorage;
  bool get isLoading => _isLoading;
  AssessmentListModel? _assessmentListModel;
  List<AssessmentList>? _assessmentList;
  List<AssessmentList>? _assessmentSubmittedList;
  List<AssessorNameList>? _houseOwnerList;

  List<AssessorNameList> get houseOwnerList => _houseOwnerList ?? [];
  List<AssessmentList> get assessmentSubmittedList =>
      _assessmentSubmittedList ?? [];
  AssessmentListModel? get assessmentListModel => _assessmentListModel;

  getAssessmentBasedOnDate(String _params, String _value) async {
    SharedPreferences.getInstance().then((token) async {
      String accessToken = token.getString("accessToken")!;
      _isLoading = true;
      notifyListeners();
      // assign_date
      final response = await get(
          Uri.parse('${BASE_URL}assessment_requests/index?$_params=$_value'),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        _assessmentList = (json.decode(response.body)['assessmentList'] as List)
            .map((e) => AssessmentList.fromJson(e))
            .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();

        throw Exception('Unexpected error occured!');
      }
    });
  }

  getAssessment() async {
    SharedPreferences.getInstance().then((token) async {
      String accessToken = token.getString("accessToken") ?? "";
      _isLoading = true;
      notifyListeners();

      final response = await get(
          Uri.parse('${BASE_URL}assessment_requests/index'),
          headers: {'Authorization': 'Bearer $accessToken'});
      print('======================================-----------------');
      if (response.statusCode == 200) {
        _assessmentList = (json.decode(response.body)['assessmentList'] as List)
            .map((e) => AssessmentList.fromJson(e))
            .toList();

        String encodeData = response.body;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('stringValue', "$encodeData");

        /// this is where you fetch the data
        // String data = GetStorageUtility.read("key");
        //
        // print("cvdcvdavdavdavdafvfdav$data");

        // if (data == null) {
        //   print('no data in GetStorage');
        // } else {
        //   Map<String, dynamic> jsonData = json.decode(data);
        //   jsonData.forEach((key, value) {
        //     print("$key :  $value\n");
        //   });
        // }
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('Unexpected error occured!');
      }
    });
  }

  getAssessmentLocal() async {
    SharedPreferences.getInstance().then((token) async {
      String _stringValue = token.getString("stringValue") ?? "";
      _isLoading = true;
      notifyListeners();
      //Return String

      //   stringValue =  token.getString("stringValue");
      // fetchData(accessToken);
      if (_stringValue == null) {
        print('no data in GetStorage');

        _isLoading = false;
        notifyListeners();
      } else {
        print("SHAREDDDDDDDDDD $_stringValue");

        Map<String, dynamic> map =
            jsonDecode(_stringValue.toString()); // import 'dart:convert';
        print("MAPPPPPPPPPPPPPPPPPP  ${map['assessmentList']}");

        _assessmentList =
            (json.decode(_stringValue.toString())['assessmentList'] as List)
                .map((e) => AssessmentList.fromJson(e))
                .toList();

        _isLoading = false;
        notifyListeners();
      }
      /* final response = await get(
          Uri.parse(
              '${BASE_URL}assessment_requests/index'),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        _assessmentList = (json.decode(response.body)['assessmentList'] as List)
            .map((e) => AssessmentList.fromJson(e))
            .toList();

        String encodeData = response.body;


        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('stringValue', "$encodeData");




        // }
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('Unexpected error occured!');
      }*/
    });
  }

  getSubmittedAssessment() async {
    SharedPreferences.getInstance().then((token) async {
      String accessToken = token.getString("accessToken") ?? "";
      _isLoading = true;
      notifyListeners();

      final response = await get(
          Uri.parse('${BASE_URL}assessment_requests/submited_form'),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        _assessmentSubmittedList =
            (json.decode(response.body)['assessmentList'] as List)
                .map((e) => AssessmentList.fromJson(e))
                .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('Unexpected error occured!');
      }
    });
  }

  getHouseOwnerList(String _search) {
    SharedPreferences.getInstance().then((token) async {
      String accessToken = token.getString("accessToken") ?? "";
      _isLoading = true;
      notifyListeners();

      final response = await get(
          Uri.parse('${BASE_URL}house_owner_list?search=$_search'),
          headers: {'Authorization': 'Bearer ${accessToken}'});
      if (response.statusCode == 200) {
        _houseOwnerList = (json.decode(response.body)['assessmentList'] as List)
            .map((e) => AssessorNameList.fromJson(e))
            .toList();

        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('Unexpected error occured!');
      }
    });
  }

  getSubmitedBasedOnDate(String params, String value) async {
    SharedPreferences.getInstance().then((token) async {
      String accessToken = token.getString("accessToken")!;
      _isLoading = true;
      notifyListeners();
      // assign_date
      final response = await get(
          Uri.parse(
              '${BASE_URL}assessment_requests/submited_form?$params=$value'),
          headers: {'Authorization': 'Bearer $accessToken'});
      if (response.statusCode == 200) {
        _assessmentSubmittedList =
            (json.decode(response.body)['assessmentList'] as List)
                .map((e) => AssessmentList.fromJson(e))
                .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
        throw Exception('Unexpected error occured!');
      }
    });
  }

  List<AssessmentList> get assessmentList => _assessmentList ?? [];
}
