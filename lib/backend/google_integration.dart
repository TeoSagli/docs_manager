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
import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:test/expect.dart';

const _scopes = [
  'https://www.googleapis.com/auth/drive.file',
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/drive.appdata',
  'https://www.googleapis.com/auth/drive.scripts',
  'https://www.googleapis.com/auth/calendar.events',
  'https://www.googleapis.com/auth/calendar',
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
  static GoogleSignInAccount? _currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    //clientId: _clientId,
    scopes: _scopes,
  );

  Future _handleSignIn() async {
    _currentUser = await _googleSignIn.signIn();
  }

  removeCalendarExpiration(String fileName) async {
    var headers = await _currentUser?.authHeaders;
    if (headers == null) {
      try {
        await _handleSignIn();
      } catch (error) {
        if (kDebugMode) print(error);
        return AlertMessage(false, "Login error!");
      }
      headers = await _currentUser?.authHeaders;
      if (headers == null) return AlertMessage(false, "Login error!");
    }

    try {
      final client = GoogleAuthClient(headers);

      var calendar = CalendarApi(client);
      String calendarId = "primary";

      Events events = await calendar.events.list(calendarId);
      List<Event>? eventsList = events.items;

      String eventID = "";

      if (eventsList != null) {
        for (var i = 0; i < eventsList.length; i++) {
          if (eventsList[i].summary == "Expiration of $fileName" &&
              eventsList[i].status != "cancelled") {
            String? id = eventsList[i].id;
            if (id != null) {
              eventID = id;
            }
            break;
          }
        }
      }

      if (eventID == "") return AlertMessage(false, "Event not created!");

      calendar.events.delete(calendarId, eventID);
    } catch (e) {
      if (kDebugMode) {
        print('Error creating event $e');
      }
      return AlertMessage(false, "An error occured!");
    }

    return AlertMessage(true, "Event removed");
  }

  dynamic addCalendarExpiration(
      FileModel file, String fileName, String expiration) async {
    var headers = await _currentUser?.authHeaders;
    if (headers == null) {
      try {
        await _handleSignIn();
      } catch (error) {
        if (kDebugMode) print(error);
        return AlertMessage(false, "Login error!");
      }
      headers = await _currentUser?.authHeaders;
      if (headers == null) return AlertMessage(false, "Login error!");
    }

    try {
      final client = GoogleAuthClient(headers);
      DateTime expirationDate = DateTime.parse(expiration);

      Event event = Event(); // Create object of event
      event.summary = "Expiration of $fileName"; //Setting summary of object

      EventDateTime start = EventDateTime();
      start.timeZone = DateTime.now().timeZoneName; //Setting start time
      start.dateTime = expirationDate;
      event.start = start;

      EventDateTime end = EventDateTime();
      end.timeZone = DateTime.now().timeZoneName; //Setting start time
      end.dateTime = expirationDate;
      event.end = end;

      var calendar = CalendarApi(client);
      String calendarId = "primary";

      var exists = false;

      Events events = await calendar.events.list(calendarId);
      List<Event>? eventsList = events.items;

      if (eventsList != null) {
        for (var i = 0; i < eventsList.length; i++) {
          if (eventsList[i].summary == "Expiration of $fileName" &&
              eventsList[i].status != "cancelled") {
            exists = true;
            break;
          }
        }
      }

      if (exists) return AlertMessage(false, "Event already created!");

      calendar.events.insert(event, calendarId).then((value) {
        if (value.status == "confirmed") {
          if (kDebugMode) {
            print('Event added in google calendar');
          }
        } else if (kDebugMode) {
          print("Unable to add event in google calendar");
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error creating event $e');
      }
      return AlertMessage(false, "An error occured!");
    }

    return AlertMessage(true, "Event added in calendar");
  }

  dynamic upload(FileModel file, String fileName) async {
    int filesNumber = file.path.length;

    var headers = await _currentUser?.authHeaders;
    if (headers == null) {
      try {
        await _handleSignIn();
      } catch (error) {
        if (kDebugMode) print(error);
        return AlertMessage(false, "Login error!");
      }

      headers = await _currentUser?.authHeaders;
      if (headers == null) return AlertMessage(false, "Login error!");
    }

    final client = GoogleAuthClient(headers);

    var drive = ga.DriveApi(client);
    var readDB = ReadDB();

    ga.File response;

    for (int i = 0; i < filesNumber; i++) {
      try {
        File fileToUpload = await readDB.readGenericFileFromNameStorage(
            i.toString(),
            file.categoryName,
            file.extension[i].toString(),
            fileName);

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
