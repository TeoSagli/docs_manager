import 'package:firebase_database/firebase_database.dart';

onUpdateNFiles(String nameCat) {
  return FirebaseDatabase.instance
      .ref("files/$nameCat")
      .onValue
      .listen((event) {
    //load num of files
    FirebaseDatabase.instance
        .ref("categories/$nameCat")
        .update({
          "nfiles": event.snapshot.children.length,
        })
        .then((value) => print("Nfiles updated!"))
        .catchError((error) => print("An error occured!"));
  });
}
