// To parse this JSON data, do
//
//     final activityResponse = activityResponseFromJson(jsonString);

import 'dart:convert';

class ActivityResponse {
    String returncode;
    String message;
    List<Activity> data;

    ActivityResponse({
        required this.returncode,
        required this.message,
        required this.data,
    });

    factory ActivityResponse.fromRawJson(String str) => ActivityResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ActivityResponse.fromJson(Map<String, dynamic> json) => ActivityResponse(
        returncode: json["returncode"],
        message: json["message"],
        data: List<Activity>.from(json["data"].map((x) => Activity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "returncode": returncode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Activity {
    String? volunteerid;
    String date;
    String address;
    String volunteer;
    String helist;
    String male;
    String female;

    Activity({
        this.volunteerid,
        required this.date,
        required this.address,
        required this.volunteer,
        required this.helist,
        required this.male,
        required this.female,
    });

    factory Activity.fromRawJson(String str) => Activity.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        volunteerid: json["volunteerid"].toString(),
        date: json["date"],
        address: json["address"],
        volunteer: json["volunteer"],
        helist: json["helist"],
        male: json["male"].toString(),
        female: json["female"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "volunteerid": volunteerid,
        "date": date,
        "address": address,
        "volunteer": volunteer,
        "helist": helist,
        "male": int.parse(male),
        "female": int.parse(female),
    };
}
