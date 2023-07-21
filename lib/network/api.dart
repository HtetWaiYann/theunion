import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:theunion/models/activity.dart';
import 'package:theunion/models/patient.dart';
import 'package:theunion/models/user.dart';
import 'package:theunion/resources/app_config.dart';
import 'dart:convert';

import 'package:theunion/services/functions_provider.dart';

class API {
  final String _baseURL = "https://35.240.209.251/api";
  final _header = {"Content-Type": "application/json"};
  final _functionsProvider = FunctionsProvider();

  Future<UserResponse> signin(String username, String password) async {
    final body = {"email": username, "password": password};

    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/auth/signin"),
          body: resBody, headers: _header);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }

    if (response.statusCode == 200) {
      UserResponse user = UserResponse.fromRawJson(response.body);
      if (user.returncode == '200') {
        return user;
      } else {
        throw Exception(user.message);
      }
    } else {
      throw Exception("Invalid Username or Password.");
    }
  }

  Future<List<Patient>> getPatientReferrals() async {
    String token = await _functionsProvider.getToken();
    var tokenHeader = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final body = {};
    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/patients/get"),
          body: resBody, headers: tokenHeader);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }

    if (response.statusCode == 200) {
      PatientResponse resp = PatientResponse.fromRawJson(response.body);
      if (resp.returncode == '200') {
        return resp.data;
      } else {
        throw Exception(resp.message);
      }
    } else {
      throw Exception(ERROR_MESSAGE);
    }
  }

  Future<List<Patient>> addPatientReferral(Patient patient) async {
    String token = await _functionsProvider.getToken();
    var tokenHeader = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    var body = patient.toJson();
    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/patients/add"),
          body: resBody, headers: tokenHeader);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }

    if (response.statusCode == 201) {
      PatientResponse resp = PatientResponse.fromRawJson(response.body);
      if (resp.returncode == '200') {
        return resp.data;
      } else {
        throw Exception(resp.message);
      }
    } else {
      throw Exception(ERROR_MESSAGE);
    }
  }

  Future<List<Activity>> getActivityList() async {
    String token = await _functionsProvider.getToken();
    var tokenHeader = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final body = {};
    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/volunteers/get"),
          body: resBody, headers: tokenHeader);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }

    if (response.statusCode == 200) {
      ActivityResponse resp = ActivityResponse.fromRawJson(response.body);
      if (resp.returncode == '200') {
        return resp.data;
      } else {
        throw Exception(resp.message);
      }
    } else {
      throw Exception(ERROR_MESSAGE);
    }
  }

  Future addHEActivity(Activity activity) async {
    String token = await _functionsProvider.getToken();
    var tokenHeader = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    var body = activity.toJson();
    final resBody = jsonEncode(body);
    var response;
    try {
      response = await http.post(Uri.parse("$_baseURL/volunteers/add"),
          body: resBody, headers: tokenHeader);
    } catch (e) {
      throw Exception(CONNECTION_ERROR);
    }
    if (response.statusCode == 201) {
      ActivityResponse resp = ActivityResponse.fromRawJson(response.body);
      if (resp.returncode == '200') {
        return resp.data;
      } else {
        throw Exception(resp.message);
      }
    } else {
      throw Exception(ERROR_MESSAGE);
    }
  }
}
