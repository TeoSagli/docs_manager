import 'dart:async';
import 'dart:convert' show json;
import 'dart:io';

import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;

const _scopes = [
  'https://www.googleapis.com/auth/drive.file',
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/drive.appdata',
  'https://www.googleapis.com/auth/drive.scripts'
];

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

class AlertMessage {
  bool success;
  final String message;

  AlertMessage(this.success, this.message);
}

class GoogleManager {
  GoogleSignInAccount? _currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    //clientId: _clientId,
    scopes: _scopes,
  );

  Future _handleSignIn() async {
    _currentUser = await _googleSignIn.signIn();
  }

  Future<AlertMessage> upload(FileModel file, String fileName) async {
    int filesNumber = file.path.length;

    var headers = await _currentUser?.authHeaders;
    if (headers == null) {
      try {
        await _handleSignIn();
      } catch (error) {
        if (kDebugMode) print(error);
        return AlertMessage(false, error.toString());
      }

      headers = await _currentUser?.authHeaders;
      if (headers == null) return AlertMessage(false, "Login error!");
    }

    final client = GoogleAuthClient(headers);

    var drive = ga.DriveApi(client);

    ga.File response;

    for (int i = 0; i < filesNumber; i++) {
      try {
        File fileToUpload = await readGenericFileFromNameStorage(i.toString(),
            file.categoryName, file.extension[i].toString(), fileName);

        print(fileToUpload.path);
        response = await drive.files.create(ga.File()..name = fileName,
            uploadMedia:
                ga.Media(fileToUpload.openRead(), fileToUpload.lengthSync()));
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
        return AlertMessage(false, "An error occured!");
      }

      if (kDebugMode) {
        print("Result ${response.toJson()}");
      }
    }

    return AlertMessage(true, "Upload completed!");
  }
}
