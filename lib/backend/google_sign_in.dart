import 'dart:async';
import 'dart:convert' show json;

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
//======================================================================
///Retrieve user info
//======================================================================
Future<void> handleGetContact(GoogleSignInAccount user) async {
  print('Loading contact info...');

  final http.Response response = await http.get(
    Uri.parse('https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names'),
    headers: await user.authHeaders,
  );
  if (response.statusCode != 200) {
    print('People API gave a ${response.statusCode} '
        'response. Check logs for details.');

    print('People API ${response.statusCode} response: ${response.body}');
    return;
  }
  final Map<String, dynamic> data =
      json.decode(response.body) as Map<String, dynamic>;
  final String? namedContact = pickFirstNamedContact(data);

  if (namedContact != null) {
    print('I see you know $namedContact!');
  } else {
    print('No contacts to display.');
  }
}

//======================================================================
///Find the first user result
//======================================================================
String? pickFirstNamedContact(Map<String, dynamic> data) {
  final List<dynamic>? connections = data['connections'] as List<dynamic>?;
  final Map<String, dynamic>? contact = connections?.firstWhere(
    (dynamic contact) => contact['names'] != null,
    orElse: () => null,
  ) as Map<String, dynamic>?;
  if (contact != null) {
    final Map<String, dynamic>? name = contact['names'].firstWhere(
      (dynamic name) => name['displayName'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (name != null) {
      return name['displayName'] as String?;
    }
  }
  return null;
}

//======================================================================
///Try to sign in and handle errors
//======================================================================
Future<void> handleSignIn() async {
  try {
    await _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

//======================================================================
///Sign out
//======================================================================
Future<void> handleSignOut() => _googleSignIn.disconnect();
