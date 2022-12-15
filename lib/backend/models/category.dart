import 'package:flutter/material.dart';

//===========================================================
//Model of category
class Category {
  final String path;
  int nfiles;
  final int colorValue;
  int order;
  Category(
      {required this.path,
      required this.nfiles,
      required this.colorValue,
      required this.order});

//Method converting a Json(Map<String, dynamic>) to a Category
  factory Category.fromRTDB(Map<String, dynamic> data) {
    return Category(
        path: data['path'],
        nfiles: data['nfiles'],
        colorValue: data['colorValue'],
        order: data['order']);
  }
}
//===========================================================
