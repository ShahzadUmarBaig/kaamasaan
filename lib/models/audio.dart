// To parse this JSON data, do
//
//     final audioResponse = audioResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Audio {
  Audio({
    required this.code,
    required this.data,
    required this.message,
    required this.status,
  });

  int code;
  Data data;
  String message;
  String status;

  factory Audio.fromRawJson(String str) => Audio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Audio.fromJson(Map<String, dynamic> json) {
    int code = json['code'];

    Data data = Data(english: "", fileUrl: "", urdu: "");

    return Audio(
      code: json["code"],
      data: code != 200 ? data : Data.fromJson(json["data"]),
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    required this.english,
    required this.fileUrl,
    required this.urdu,
  });

  String english;
  String fileUrl;
  String urdu;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        english: json["english"],
        fileUrl: json["file_url"],
        urdu: json["urdu"],
      );

  Map<String, dynamic> toJson() => {
        "english": english,
        "file_url": fileUrl,
        "urdu": urdu,
      };
}
