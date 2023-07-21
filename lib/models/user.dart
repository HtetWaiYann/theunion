import 'dart:convert';

class UserResponse {
    String returncode;
    String message;
    Data? data;

    UserResponse({
        required this.returncode,
        required this.message,
        this.data,
    });

    factory UserResponse.fromRawJson(String str) => UserResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        returncode: json["returncode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "returncode": returncode,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String token;
    String userid;

    Data({
        required this.token,
        required this.userid,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userid: json["userid"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "userid": userid,
    };
}
