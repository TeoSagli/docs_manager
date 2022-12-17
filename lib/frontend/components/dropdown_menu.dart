import 'dart:async';

import 'package:docs_manager/backend/category_read_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyDropdown extends StatefulWidget {
  String dropdownValue = "";
  MyDropdown(this.dropdownValue, {super.key});

  @override
  State<StatefulWidget> createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  List<String> categoriesNames = [];

  late StreamSubscription readCategoriesNames;
//===================================================================================
// Activate listeners
  @override
  void initState() {
    categoriesNames.clear();
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
      padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
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
            isExpanded: true,
            value: widget.dropdownValue,
            icon: const Icon(Icons.arrow_drop_down_rounded),
            elevation: 16,
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                widget.dropdownValue = value!;
              });
            },
            items:
                categoriesNames.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value.toString(),
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
      widget.dropdownValue = categoriesNames.first;
    });
  }
}
//===================================================================================
