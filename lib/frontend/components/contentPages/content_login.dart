import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:docs_manager/others/constants.dart' as constants;
import 'package:firebase_auth/firebase_auth.dart';

class ContentLogin extends StatefulWidget {
  const ContentLogin({super.key});

  @override
  State<ContentLogin> createState() => ContentLoginState();
}

class ContentLoginState extends State<ContentLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserCredsModel um1;

  @override
  void initState() {
    setState(() {
      um1 = UserCredsModel("", "");
    });
    super.initState();
  }

//======================================================================
  ///Build sign in screen
//======================================================================

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
          child: SizedBox(
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
                  autofocus: false,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    icon: Icon(Icons.account_circle_rounded),
                  ),
                  validator: (String? value) {
                    if (EmailValidator.validate(value!)) {
                      um1.setEmail(value);
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
                        um1.setPassword(value);
                      }
                      return null;
                    },
                  ),
                ),
              ),
              MyButton("Login", loginOps),
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
      ],
    );
  }

//========================================================
  ///Login on button pressed
  Future<bool> login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await signIn(um1.email, um1.password);
        return true;
      } on FirebaseAuthException catch (e) {
        onErrorFirebase(context, e);
      } catch (e) {
        onErrorGeneric(context, e);
      }
    }
    return false;
  }

//========================================================
  ///Login operations
  loginOps() {
    login().then((value) {
      if (value) onLoginConfirmed(context, '/');
    });
  }

//========================================================
  ///Sign in with firebase
  signIn(email, password) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //========================================================
  ///Login on button pressed
  moveToRegisterPage() {
    Navigator.pushNamed(context, "/register");
  }
  //========================================================
}
