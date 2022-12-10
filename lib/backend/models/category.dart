import 'package:flutter/material.dart';

//===========================================================
//Model of category
class Category {
  final String path;
  final int nfiles;
  final int colorValue;
  Category(
      {required this.path, required this.nfiles, required this.colorValue});

//Method converting a Json(Map<String, dynamic>) to a Category
  factory Category.fromRTDB(Map<String, dynamic> data) {
    return Category(
        path: data['path'],
        nfiles: data['nfiles'],
        colorValue: data['colorValue']);
  }
}
//===========================================================
