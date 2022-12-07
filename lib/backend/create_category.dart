import 'package:firebase_database/firebase_database.dart';

createCategory(name, path) async {
  final categoriesKey =
      FirebaseDatabase.instance.ref().child('categories/').push().key;
  print(categoriesKey);
  var newCategory = FirebaseDatabase.instance.ref("categories/$categoriesKey/");
  await newCategory.set({
    "name": name,
    "path": path,
  });
}
