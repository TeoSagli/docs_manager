import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HandleRegistration {
  UserCredsModel user = UserCredsModel("", "");
  HandleRegistration(this.user);

  bool register(BuildContext context) {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((value) {
        createUserDB(user.email, value.user!.uid);
        createDefaultCategoriesDB();
        onLoad(context);
        Future.delayed(
            const Duration(seconds: 5),
            () => FirebaseAuth.instance
                .signOut()
                .then((value) => onRegistrationConfirmed(context, '/')));
        return true;
      }).onError((error, stackTrace) => onErrorFirebase(context, error));
    } on FirebaseAuthException catch (e) {
      onErrorFirebase(context, e);
    } catch (e) {
      onErrorGeneric(context, e);
    }
    return false;
  }

  setUser(UserCredsModel u) {
    user = u;
  }
}
