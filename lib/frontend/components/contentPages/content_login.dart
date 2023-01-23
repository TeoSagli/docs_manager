import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/frontend/components/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ContentLogin extends StatefulWidget {
  final dynamic handleLogin;
  final dynamic onErrorGeneric;
  final dynamic onErrorFirebase;
  final dynamic onLoginConfirmed;
  final dynamic moveToRegisterPage;
  final dynamic context;
  const ContentLogin(this.handleLogin, this.context, this.onErrorGeneric,
      this.onErrorFirebase, this.onLoginConfirmed, this.moveToRegisterPage,
      {super.key});

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
                  key: const Key("email"),
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
                    key: const Key("password"),
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
                      onPressed: () =>
                          widget.moveToRegisterPage(context, "/register"),
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
  ///Login operations
  loginOps() {
    if (_formKey.currentState!.validate()) {
      widget
          .handleLogin(um1, widget.context, widget.onErrorFirebase,
              widget.onErrorGeneric)
          .then((value) {
        if (value) widget.onLoginConfirmed(context, '/');
      });
    }
  }

  //========================================================

}
