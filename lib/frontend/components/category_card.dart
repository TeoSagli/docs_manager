import 'package:docs_manager/backend/models/category.dart';
import 'package:firebase_database/firebase_database.dart';
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
                              backgroundColor: Color(0xFFFF5252),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/test.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
