import 'dart:async';

import 'package:docs_manager/backend/category_read_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  State<StatefulWidget> createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  List<String> categoriesNames = [];
  String dropdownValue = "";
  late StreamSubscription readCategoriesNames;
//===================================================================================
// Activate listeners
  @override
  void initState() {
    readCategoriesNames = retrieveCategoriesNamesDB(fillCategoriesNames);
    super.initState();
  }

//===================================================================================
// Deactivate listeners
  @override
  void deactivate() {
    readCategoriesNames.cancel();
    super.deactivate();
  }

//===================================================================================
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items:
                categoriesNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

//===================================================================================
// Add category to menu
  fillCategoriesNames(String el) {
    setState(() {
      categoriesNames.add(el);
    });
  }
}
//===================================================================================
