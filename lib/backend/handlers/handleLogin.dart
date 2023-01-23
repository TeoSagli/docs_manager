import 'package:docs_manager/backend/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HandleLogin {
  UserCredsModel user = UserCredsModel("", "");
  HandleLogin(this.user);

  //========================================================
  ///Login on button pressed
  Future<bool> login(u, context, onErrorFirebase, onErrorGeneric) async {
    try {
      setUser(u);
      await signIn(user.email, user.password);
      return true;
    } on FirebaseAuthException catch (e) {
      onErrorFirebase(context, e);
    } catch (e) {
      onErrorGeneric(context, e);
    }

    return false;
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
  ///Set user
  setUser(UserCredsModel u) {
    user = u;
  }
}
