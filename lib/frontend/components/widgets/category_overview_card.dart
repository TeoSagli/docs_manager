import 'package:docs_manager/backend/models/category.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class CategoryOverviewCard extends StatefulWidget {
  final String categoryName;
  final CategoryModel category;
  final dynamic function;
  final dynamic initCardFromDB;

  @override
  State<StatefulWidget> createState() => CategoryOverviewCardState();

  const CategoryOverviewCard(
      this.categoryName, this.category, this.function, this.initCardFromDB,
      {super.key});
}

class CategoryOverviewCardState extends State<CategoryOverviewCard> {
  Widget cardImage = constants.loadingWheel2;
  Color cardColor = Colors.white;

  @override
  void initState() {
    if (mounted) {
      setState(() {
        cardColor = Color(widget.category.colorValue);
      });
    }

    widget.initCardFromDB(widget.category.path, setCard);
    super.initState();
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
          child: GestureDetector(
            key: const Key("tap-widget"),
            onTap: () => widget.function(widget.categoryName, context),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
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
                    padding: const EdgeInsetsDirectional.all(5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.categoryName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 18,
                        ),
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

  setCard(Uint8List file) {
    if (mounted) {
    setState(() {
      cardImage = Image.memory(
        file,
        width: double.infinity,
        height: 100,
        cacheHeight: 500,
        fit: BoxFit.cover,
      );
    });
    }
  }
}
