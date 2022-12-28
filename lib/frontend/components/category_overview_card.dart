import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/backend/models/category.dart';
import 'package:flutter/material.dart';
import 'abstract/card.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class CategoryOverviewCard extends StatefulWidget {
  final String categoryName;
  final CategoryModel category;
  final dynamic function;

  @override
  State<StatefulWidget> createState() => CategoryOverviewCardState();
  const CategoryOverviewCard(this.categoryName, this.category, this.function,
      {super.key});
}

class CategoryOverviewCardState extends State<CategoryOverviewCard>
    with MyCard {
  Widget cardImage = constants.loadingWheel2;
  @override
  onExitHover() {
    setState(() {
      cardColor = Color(widget.category.colorValue);
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
    cardColor = Color(widget.category.colorValue);
    readImageCategoryStorage(widget.category.path, setCard);
    super.initState();
  }

  @override
  void didUpdateWidget(CategoryOverviewCard oldWidget) {
    readImageCategoryStorage(widget.category.path, setCard);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 24, 12, 12),
      child: Container(
        width: 270,
        height: 100,
        decoration: BoxDecoration(
          color: cardColor,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x25000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: MouseRegion(
          onEnter: ((event) => onHover()),
          onExit: ((event) => onExitHover()),
          child: GestureDetector(
            onTap: () => widget.function(widget.categoryName, context),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: cardImage),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(4, 10, 4, 0),
                    child: Text(
                      widget.categoryName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
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

  setCard(file) {
    setState(() {
      cardImage = Image.memory(
        file,
        width: double.infinity,
        height: 100,
        fit: BoxFit.cover,
      );
    });
  }
}
