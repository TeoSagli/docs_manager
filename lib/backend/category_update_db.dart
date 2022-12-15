import 'package:firebase_database/firebase_database.dart';

import 'models/category.dart';

//===================================================================================
// Update order value DB
updateOrderDB(List<int> items) async {
  print("AO $items");
  int count = 0;
  final dbRef = FirebaseDatabase.instance.ref("categories");
  dbRef.get().asStream().forEach((element) {
    for (var el in element.children) {
      dbRef.child(el.key!).update({"order": items.elementAt(count)});
      count++;
    }
  });
}
