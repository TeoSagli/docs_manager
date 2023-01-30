import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ContentRegister extends StatefulWidget {
  final dynamic handleRegister;
  final dynamic setUser;
  final dynamic context;

  const ContentRegister(this.handleRegister, this.setUser, this.context,
      {super.key});

  @override
  State<ContentRegister> createState() => ContentRegisterState();
}

class ContentRegisterState extends State<ContentRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserCredsModel um1;

  @override
  void initState() {
    setState(() {
      imageCache.clear();
      imageCache.clearLiveImages();

      um1 = UserCredsModel("", "");
    });
    super.initState();
  }

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
              "Register an account!",
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
              "Choose an email and a password",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Image.asset('assets/images/Registration.png',
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
              MyButton("Register", registerOps),
            ],
          ),
        ),
      ],
    );
  }

  //========================================================
  ///register operations
  ///
  registerOps() {
    if (_formKey.currentState!.validate()) {
      widget.setUser(um1);
      widget.handleRegister(widget.context);
    }
  }
}
