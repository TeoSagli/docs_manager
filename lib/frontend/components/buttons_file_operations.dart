import 'package:docs_manager/backend/google_integration.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'dart:io';

class ButtonsFileOperations extends StatefulWidget {
  final FileModel file;
  final dynamic moveToEditFilePage;
  final dynamic removeCard;
  final String fileName;
  const ButtonsFileOperations(
      this.fileName, this.file, this.moveToEditFilePage, this.removeCard,
      {super.key});

  @override
  State<StatefulWidget> createState() => ButtonsFileOperationsState();
}

class ButtonsFileOperationsState extends State<ButtonsFileOperations> {
  late bool isFav;
  @override
  void initState() {
    setState(() {
      isFav = widget.file.isFavourite;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 7,
              color: Color(0x2F1D2429),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                splashColor: constants.mainBackColor,
                color: constants.mainBackColor,
                icon: const Icon(Icons.mode_edit_outline_rounded),
                onPressed: () =>
                    widget.moveToEditFilePage(widget.fileName, context),
              ),
              IconButton(
                color: constants.mainBackColor,
                icon: const Icon(Icons.download),
                onPressed: () => {},
              ),
              IconButton(
                color: constants.mainBackColor,
                icon: const Icon(Icons.add_to_drive_rounded),
                onPressed: () async {
                  var drive = GoogleDrive();
                  /*    GoogleDrive googleDrive = GoogleDrive();
                  googleDrive.uploadFileToGoogleDrive();*/
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    await drive.upload(file, "my test file");
                  } else {
                    // User canceled the picker
                  }
                },
              ),
              IconButton(
                  color: constants.mainBackColor,
                  icon: Icon(isFav
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded),
                  onPressed: () {
                    setState(() {
                      isFav = !isFav;
                    });
                    updateFavouriteDB(
                        widget.file.categoryName, widget.fileName, isFav);
                  }),
              IconButton(
                color: Colors.redAccent,
                icon: const Icon(Icons.delete_rounded),
                onPressed: () =>
                    onDeleteFile(context, widget.removeCard, widget),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
