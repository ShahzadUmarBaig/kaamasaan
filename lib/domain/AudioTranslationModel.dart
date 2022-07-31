// import 'package:dartz/dartz.dart';
//
// class AudioTranslationModel {
//   final int apiCode;
//   final Either<List, TranslatedData> data;
//   final String message;
//   final String status;
//
//   AudioTranslationModel({
//     required this.apiCode,
//     required this.data,
//     required this.message,
//     required this.status,
//   });
//
//   factory AudioTranslationModel.fromJSON(Map<String, dynamic> json) {
//     return AudioTranslationModel(
//       apiCode: json["code"],
//       data: json["data"].runtimeType == List
//           ? left(json["data"])
//           : right(TranslatedData.fromJSON(json["data"])),
//       message: json["message"],
//       status: json["status"],
//     );
//   }
//
//   Map<String, dynamic> toJSON() {
//     return {
//       "code": this.apiCode,
//       "data": this.data.fold((l) => [], (r) => r.toJSON()),
//       "message": this.message,
//       "status": this.status,
//     };
//   }
// }
//
// class TranslatedData {
//   final String english;
//   final String urdu;
//   final String fileURL;
//
//   TranslatedData({
//     required this.english,
//     required this.urdu,
//     required this.fileURL,
//   });
//
//   factory TranslatedData.fromJSON(Map<String, dynamic> json) {
//     return TranslatedData(
//       english: json["english"],
//       urdu: json["urdu"],
//       fileURL: json["file_url"],
//     );
//   }
//
//   Map<String, dynamic> toJSON() {
//     return {
//       "english": this.english,
//       "urdu": this.urdu,
//       "file_url": this.fileURL,
//     };
//   }
// }
