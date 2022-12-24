import 'dart:io';

import 'package:docs_manager/backend/google_integration.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ContentLogin extends StatefulWidget {
  const ContentLogin({super.key});

  @override
  State<ContentLogin> createState() => ContentLoginState();
}

class ContentLoginState extends State<ContentLogin> {
  late final drive;

  @override
  void initState() {
    drive = GoogleDrive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                child: Text("UPLOAD"),
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    await drive.upload(file);
                  } else {
                    // User canceled the picker
                  }
                })
          ],
        ),
      ),
    );
  }
}
