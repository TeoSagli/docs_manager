import 'package:firebase_database/firebase_database.dart';

import 'models/category.dart';

//===================================================================================
// Update order value DB
updateOrderDB(int index, String catName) async {
  final dbRef = FirebaseDatabase.instance.ref("categories/$catName");
  await dbRef.update({"order": index});
}
//===================================================================================d