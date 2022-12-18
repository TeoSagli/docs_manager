import 'package:flutter/material.dart';

//===========================================================
//Model of File
class File {
  final List<Object?> path;
  final IconData icon;
  final String categoryName;
  final String subTitle1;
  bool isFavourite;
  File({
    required this.path,
    required this.categoryName,
    required this.subTitle1,
    required this.icon,
    required this.isFavourite,
  });

//Method converting a Json(Map<String, dynamic>) to a File
  factory File.fromRTDB(Map<String, dynamic> data) {
    /*  return File(
        path: data['path'],
        categoryName: data['categoryName'],
        subTitle1: data['subTitle1'],
        icon: data['icon']);*/
    return File(
        path: data['path'],
        categoryName: data['categoryName'],
        subTitle1: '216 Members',
        icon: Icons.category,
        isFavourite: data['isFavourite']);
  }
}
//===========================================================
