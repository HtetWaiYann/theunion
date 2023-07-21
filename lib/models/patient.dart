import 'dart:convert';

class PatientResponse {
  String returncode;
  String message;
  List<Patient> data;

  PatientResponse({
    required this.returncode,
    required this.message,
    required this.data,
  });

  factory PatientResponse.fromRawJson(String str) =>
      PatientResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      PatientResponse(
        returncode: json["returncode"],
        message: json["message"],
        data: List<Patient>.from(json["data"].map((x) => Patient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "returncode": returncode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Patient {
  String patientid;
  String name;
  String age;
  String sex;
  String referDate;
  String township;
  String address;
  String referFrom;
  String referTo;
  String signAndSymptom;

  Patient({
    required this.patientid,
    required this.name,
    required this.age,
    required this.sex,
    required this.referDate,
    required this.township,
    required this.address,
    required this.referFrom,
    required this.referTo,
    required this.signAndSymptom,
  });

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
      patientid: json["patientid"] ?? '',
      name: json["name"],
      age: json["age"].toString(),
      sex: json["sex"],
      referDate: json["referDate"],
      township: json["township"],
      address: json["address"],
      referFrom: json["referFrom"],
      referTo: json["referTo"],
      signAndSymptom: json["signAndSymptom"]);

  Map<String, dynamic> toJson() => {
        "patientid": patientid,
        "name": name,
        "age": int.parse(age),
        "sex": sex,
        "referDate": referDate.toString(),
        "township": township,
        "address": address,
        "referFrom": referFrom,
        "referTo": referTo,
        "signAndSymptom": signAndSymptom,
      };
}
