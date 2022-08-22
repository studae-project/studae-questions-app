import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class ImageUploadButton extends StatefulWidget {
  final Function(List<Uint8List> uploadFiles) whenPickAllFiles;

  const ImageUploadButton(this.whenPickAllFiles, {Key? key}) : super(key: key);

  @override
  State<ImageUploadButton> createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  List<PlatformFile> chosenFiles = List.empty(growable: true);

  void pickImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, allowCompression: true, type: FileType.image);

    if (result != null) {
      var totalFiles = result.count;

      if (totalFiles > 5) {
        Fluttertoast.showToast(
          msg: "Você só pode enviar 5 arquivos no máximo.",
          toastLength: Toast.LENGTH_LONG,
          webBgColor: "#E57373",
          webPosition: "center",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          webShowClose: true,
          textColor: Colors.white,
          fontSize: 5.sp,
        );
        return;
      }

      setState(() {
        chosenFiles = result.files;
        var listOfBytes = result.files
            .where((element) => element.bytes != null)
            .map((e) => e.bytes!)
            .toList();
        widget.whenPickAllFiles(listOfBytes);
      });
    }
  }

  List<Widget> chosenFilesToImages() {
    return chosenFiles.map((e) {
      if (e.bytes != null) {
        return Padding(
          padding: EdgeInsets.only(left: 1.w, right: 1.w),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54, width: 0.2.w)),
              constraints: BoxConstraints(maxWidth: 5.w, maxHeight: 5.w),
              child: Image.memory(e.bytes!)),
        );
      }
      return Container();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        children: [
          SizedBox(
            height: 7.h,
            width: 13.w,
            child: ElevatedButton(
                onPressed: () => pickImages(),
                child: Row(
                  children: [
                    Icon(
                      Icons.upload_file,
                      size: 2.w,
                    ),
                    SizedBox(
                      width: 1.h,
                    ),
                    Text(
                      "Anexar Imagens",
                      style: TextStyle(fontSize: 3.2.sp),
                    )
                  ],
                )),
          ),
        ],
      ),
      ...chosenFilesToImages()
    ]);
  }
}
