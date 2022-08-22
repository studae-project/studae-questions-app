import 'dart:typed_data';

class Question {
  late String question;
  late List<Uint8List> images;

  Question();

  Map<String, dynamic> toMap() => {
    "text" : question,
    "channel" : "java-kotlin",
    "file" : images.first
  };
}