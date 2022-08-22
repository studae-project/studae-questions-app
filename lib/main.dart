import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:studae_questions_app/http/create_question_request.dart';
import 'package:studae_questions_app/model/question.dart';
import 'package:studae_questions_app/widget/image_upload_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          title: 'Studae Duvidas',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Question question = Question();

  void submitQuestion() {
    CreateQuestionRequest()
        .create(question)
        .whenComplete(() => Fluttertoast.showToast(
              msg: "Dúvida criada com sucesso. Acompanhe as respostas em #java-kotlin.",
              toastLength: Toast.LENGTH_LONG,
              webBgColor: "#68ff96",
              webPosition: "center",
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              webShowClose: true,
              textColor: Colors.white,
              fontSize: 5.sp,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 252, 252, 1),
      extendBody: true,
      appBar: AppBar(
        title: Image.asset("assets/logo-white.png", height: 10.w),
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Você tem alguma dúvida e gostaria de perguntar em anônimo?",
                style: TextStyle(
                    fontSize: 5.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 50.w,
                minHeight: 50.h,
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Digite aqui sua dúvida",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    style: TextStyle(fontSize: 3.5.sp),
                    expands: false,
                    maxLines: 10,
                    onChanged: (text) => question.question = text,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      ImageUploadButton(
                        (uploadFiles) => question.images = uploadFiles,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 8.h,
                          width: 20.w,
                          child: ElevatedButton(
                              onPressed: () => submitQuestion(),
                              child: Text(
                                "Enviar Dúvida",
                                style: TextStyle(
                                    fontSize: 4.sp,
                                    fontWeight: FontWeight.w800),
                              )))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
