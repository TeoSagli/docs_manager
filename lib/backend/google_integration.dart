import 'dart:io';
import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher_string.dart';

const _clientId =
    "952808555359-g3fdg8tfclave8mdq5mcoiiolh2p44tc.apps.googleusercontent.com";
const _clientSecret = "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";
const _scopes = ['https://www.googleapis.com/auth/drive.file'];

class SecureStorage {
  final storage = const FlutterSecureStorage();

  //Save Credentials
  Future saveCredentials(AccessToken token, String refreshToken) async {
    print(token.expiry.toIso8601String());
    await storage.write(key: "type", value: token.type);
    await storage.write(key: "data", value: token.data);
    await storage.write(key: "expiry", value: token.expiry.toString());
    await storage.write(key: "refreshToken", value: refreshToken);
  }

  //Get Saved Credentials
  Future<Map<String, String>?> getCredentials() async {
    var result = await storage.readAll();
    if (result.isEmpty) return null;
    return result;
  }

  //Clear Saved Credentials
  Future clear() {
    return storage.deleteAll();
  }
}

class GoogleDrive {
  final storage = SecureStorage();
  //Get Authenticated Http Client
  Future<http.Client> getHttpClient() async {
    //Get Credentials
    var credentials = await storage.getCredentials();
    if (credentials == null) {
      //Needs user authentication
      var authClient = await clientViaUserConsent(
          ClientId(_clientId, _clientSecret), _scopes, (url) {
        //Open Url in Browser
        launchUrlString(url);
        // _launchInWebViewOrVC(toLaunch);
      });
      //Save Credentials
      await storage.saveCredentials(authClient.credentials.accessToken,
          authClient.credentials.refreshToken!);
      return authClient;
    } else {
      print(credentials["expiry"]);
      //Already authenticated
      return authenticatedClient(
          http.Client(),
          AccessCredentials(
              AccessToken(credentials["type"]!, credentials["data"]!,
                  DateTime.tryParse(credentials["expiry"]!)!),
              credentials["refreshToken"],
              _scopes));
    }
  }

  //Upload File
  Future upload(File file, String fileName) async {
    var client = await getHttpClient();
    var drive = ga.DriveApi(client);
    print("Uploading file");
    var response = await drive.files.create(ga.File()..name = fileName,
        uploadMedia: ga.Media(file.openRead(), file.lengthSync()));

    print("Result ${response.toJson()}");
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }
}
