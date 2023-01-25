import 'package:docs_manager/backend/create_db.dart';
import 'package:docs_manager/backend/models/user.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandleRegistration {
  UserCredsModel user = UserCredsModel("", "");
  HandleRegistration(this.user);
  Alert a = Alert();
  register(context) {
    var createDB = CreateDB();
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      )
          .then((value) {
        createDB.createUserDB(user.email, value.user!.uid);
        createDB.createDefaultCategoriesDB();
        a.onLoad(context);
        waitFuture(context);
      }).onError((error, stackTrace) => a.onErrorFirebase(context, error));
    } on FirebaseAuthException catch (e) {
      a.onErrorFirebase(context, e);
    } catch (e) {
      a.onErrorGeneric(context, e);
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
            .then((value) => a.onRegistrationConfirmed(context, '/')));
  }

  //========================================================
  ///Set user
  setUser(UserCredsModel u) {
    user = u;
  }
}
