import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandleRegistration {
  UserCredsModel user = UserCredsModel("", "");
  HandleRegistration(this.user);

  register(context) {
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
        waitFuture(context);
      }).onError((error, stackTrace) => onErrorFirebase(context, error));
    } on FirebaseAuthException catch (e) {
      onErrorFirebase(context, e);
    } catch (e) {
      onErrorGeneric(context, e);
    }
  }

  //========================================================
  ///Sign up with firebase

  signUp(email, password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
  }

  //========================================================
  ///Wait until operation done
  ///
  waitFuture(context) {
    Future.delayed(
        const Duration(seconds: 5),
        () => FirebaseAuth.instance
            .signOut()
            .then((value) => onRegistrationConfirmed(context, '/')));
  }

  //========================================================
  ///Set user
  setUser(UserCredsModel u) {
    user = u;
  }
}
