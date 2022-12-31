import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/frontend/components/widgets/button_function.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContentRegister extends StatefulWidget {
  const ContentRegister({super.key});

  @override
  State<ContentRegister> createState() => ContentRegisterState();
}

class ContentRegisterState extends State<ContentRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String emailAddress;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
              MyButton("Register", register),
            ],
          ),
        ),
      ],
    );
  }

  register() async {
    if (_formKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        )
            .then((value) {
          createUserDB(emailAddress, value.user!.uid);
          createDefaultCategoriesDB();
          onRegistrationConfirmed(context);
        }).onError((error, stackTrace) => onErrorFirebase(context, error));
      } on FirebaseAuthException catch (e) {
        onErrorFirebase(context, e);
      } catch (e) {
        onErrorGeneric(context, e);
      }
    }
  }
}
