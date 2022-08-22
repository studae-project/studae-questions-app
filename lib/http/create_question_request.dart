import 'package:http/http.dart' as http;
import 'package:studae_questions_app/model/question.dart';

class CreateQuestionRequest {
  Future<bool> create(Question question) async {
    var host =
        const String.fromEnvironment("HOST", defaultValue: "localhost:8090");
    var url = Uri.http(host, "question");

    var request = http.MultipartRequest("POST", url);
    request.fields["text"] = question.question;
    request.fields["channel"] = "java-kotlin";
    request.files.add(http.MultipartFile.fromBytes(
        "file", question.images.first, filename: "file.png"));

    request.headers["Content-Type"] = "multipart/form-data";

    var response = await request.send();

    return response.statusCode == 201;
  }
}
