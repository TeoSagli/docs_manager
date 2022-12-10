import 'dart:typed_data';

import 'package:docs_manager/backend/models/category.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'abstract/card.dart';
import 'dart:math' as math;

class CategoryCard extends StatefulWidget {
  final String categoryName;
  final Category category;
  final String subTitle2;
  final int id;
  final dynamic function;

  @override
  State<StatefulWidget> createState() => CategoryCardState();
  const CategoryCard(
      this.categoryName, this.category, this.subTitle2, this.id, this.function,
      {super.key});
}

class CategoryCardState extends State<CategoryCard> with MyCard {
  Widget cardImage = const SizedBox.shrink();

  @override
  onExitHover() {
    setState(() {
      cardColor = Colors.white;
    });
  }

  @override
  onHover() {
    setState(() {
      cardColor = Colors.white30;
    });
  }

  @override
  void initState() {
    super.initState();
    readImageCategoryStorage(widget.category.path).then((value) => setState(() {
          cardImage = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x25000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: MouseRegion(
          onEnter: ((event) => onHover()),
          onExit: ((event) => onExitHover()),
          child: GestureDetector(
            onTap: () => widget.function(widget.id, context),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 8),
                    child: Container(
                      width: 4,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(widget.category.colorValue),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.categoryName,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF101213),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            "${widget.category.nfiles} Elements",
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(0xFF57636C),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            "${widget.category.nfiles} Elements",
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              color: Color(widget.category.colorValue),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: cardImage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Image> readImageCategoryStorage(String catName) async {
    final storageRef = FirebaseStorage.instance.ref("categories");
    // print(await storageRef.child("Pictures.png").getDownloadURL());
    print("bro $catName");
    final catRef = storageRef.child(catName);

    try {
      const oneMegabyte = 1024 * 1024;

      return await catRef
          .getData(oneMegabyte)
          .then((value) => cardImage = Image.memory(
                value!,
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ));

      // Data for "images/island.jpg" is returned, use this as needed.
    } on FirebaseException catch (e) {
      // Handle any errors.
      print("Error $e!");
    }
    return Image.asset(
      "images/test.png",
      width: 100,
      height: 100,
    );
  }
}
