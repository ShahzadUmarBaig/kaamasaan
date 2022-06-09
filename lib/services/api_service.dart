import 'package:http/http.dart' as http;

class ApiService {
  Future sendAudioFile(String filePath) async {
    String url =
        'https://zb3aeahdg2.execute-api.me-south-1.amazonaws.com/dev/predict';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('audio', filePath));

    http.StreamedResponse response = await request.send();

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
