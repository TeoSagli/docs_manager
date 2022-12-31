import 'package:docs_manager/backend/google_sign_in.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class ContentLogin extends StatefulWidget {
  const ContentLogin({super.key});

  @override
  State<ContentLogin> createState() => ContentLoginState();
}

class ContentLoginState extends State<ContentLogin> {
  GoogleSignInAccount? _currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String emailAddress;
  late String password;

  @override
  void initState() {
    super.initState();
    /* _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();*/
  }

//======================================================================
  ///Build sign in screen
//======================================================================
  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          const ElevatedButton(
            onPressed: handleSignOut,
            child: Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: handleSignIn,
            child: Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Text(
            "Login to DocuManager!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const Text(
              "The simple documents & cards manager",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Image.asset('assets/images/Login.png',
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.5),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints.tight(
                    Size(MediaQuery.of(context).size.width * 0.8, 50)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    icon: Icon(Icons.account_circle_rounded),
                  ),
                  validator: (String? value) {
                    if (EmailValidator.validate(value!)) {
                      emailAddress = value;
                      return null;
                    } else {
                      return "Please enter a valid email";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(
                      Size(MediaQuery.of(context).size.width * 0.8, 50)),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      icon: Icon(Icons.key),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else {
                        password = value;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              MyButton("Login", login),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 20, 10),
                  child: TextButton(
                      onPressed: () => moveToRegisterPage(),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        fixedSize:
                            MaterialStateProperty.all(const Size(130, 40)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: const BorderSide(
                              color: constants.mainBackColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      child: const TitleText(
                          "Register -->", constants.mainBackColor)),
                ),
              ),
            ],
          ),
        ),
        /*  ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        )*/
      ],
    );
  }

//========================================================
  ///Login on button pressed
  login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailAddress,
          password: password,
        )
            .then((value) {
          value.user!.reload();
          onLoginConfirmed(context);
        }).onError((error, stackTrace) => onErrorFirebase(context, error));
      } on FirebaseAuthException catch (e) {
        onErrorFirebase(context, e);
      } catch (e) {
        onErrorGeneric(context, e);
      }
    }
  }

  //========================================================
  ///Login on button pressed
  moveToRegisterPage() {
    Navigator.pushNamed(context, "/register");
  }
}
