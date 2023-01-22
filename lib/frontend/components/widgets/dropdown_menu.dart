import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  String dropdownValue = "";
  final dynamic initDataFromDB;

  ///My custom InputField:
  ///
  ///1-set the value change.
  ///
  ///2-set the method to cretrieve data form db.
  ///

  MyDropdown(this.dropdownValue, this.initDataFromDB, {super.key});

  @override
  State<StatefulWidget> createState() => MyDropdownState();
}

class MyDropdownState extends State<MyDropdown> {
  List<String> categoriesNames = [];
//===================================================================================
  @override
  void initState() {
    widget.initDataFromDB(fillCategoriesNames);
    super.initState();
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
  fillCategoriesNames(List<String> list) {
    setState(() {
      categoriesNames = list;
      if (widget.dropdownValue == "") {
        widget.dropdownValue = categoriesNames.first;
      }
    });
  }
}
//===================================================================================
