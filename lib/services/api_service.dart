import 'dart:convert';
import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:http/http.dart' as http;
import 'package:kaamasaan/models/audio.dart';

class ApiService {
  Future sendAudioFile(String filePath) async {
    String url =
        'https://zb3aeahdg2.execute-api.me-south-1.amazonaws.com/dev/predict';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('audio', filePath));
    try {
      http.StreamedResponse response = await request.send();
      var rawResponse = await response.stream.bytesToString();

      Audio audio = Audio.fromJson(jsonDecode(rawResponse));

      print(audio.toJson());
      if (audio.code == 200) {
        return audio;
      } else {
        throw ApiException(audio.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> convertAudioToWav(String originalFilePath) async {
    /// This is the path split into only file name e.g cache/data/blah/blah/file.aac
    /// which is then converted to file.wav
    String fileNameWithFormat = originalFilePath.split("/").last;

    /// splitting the complete filename with extension to only filename e.g file.aac to file
    String fileNameOnly = fileNameWithFormat.split(".").first;

    /// creating new file path with an extension of .wav
    String newFilePath =
        "/data/user/0/io.flutterly.kaamasaan/cache/" + fileNameOnly + ".wav";

    FFmpegSession session =
        await FFmpegKit.execute("-i $originalFilePath $newFilePath");

    final returnCode = await session.getReturnCode();

    if (returnCode != null) {
      if (ReturnCode.isSuccess(returnCode)) {
        return newFilePath;
      } else {
        throw ApiException("Failed to convert audio to wav");
      }
    } else {
      throw ApiException("Failed to convert audio to wav");
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
}
