import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kaamasaan/domain/AudioTranslationModel.dart';

class ApiService {
  Future<AudioTranslationModel> sendAudioFile(String filePath) async {
    String url =
        'https://zb3aeahdg2.execute-api.me-south-1.amazonaws.com/dev/predict';
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath('audio', filePath));

      http.StreamedResponse response = await request.send();
      String rawResponse = await response.stream.bytesToString();
      AudioTranslationModel translation =
          AudioTranslationModel.fromJSON(jsonDecode(rawResponse));
      print(translation.toJSON());
      return translation;
    } catch (e) {
      rethrow;
    }
  }
}
