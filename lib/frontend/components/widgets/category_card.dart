import 'package:docs_manager/backend/models/category.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class CategoryCard extends StatefulWidget {
  final String categoryName;
  final CategoryModel category;
  final dynamic function;
  final dynamic moveToEditCatPage;
  final dynamic removeCard;
  final dynamic initCardFromDB;
  final dynamic onDelete;

  @override
  State<StatefulWidget> createState() => CategoryCardState();
  const CategoryCard(
      this.categoryName,
      this.category,
      this.function,
      this.moveToEditCatPage,
      this.removeCard,
      this.initCardFromDB,
      this.onDelete,
      {super.key});
}

class CategoryCardState extends State<CategoryCard> {
  final hCard = 80.0;
  Widget cardImage = constants.loadingWheel2;

  @override
  void initState() {
    widget.initCardFromDB(widget.category.path, setCard);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: Color(0x25000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: MouseRegion(
        child: GestureDetector(
          key: const Key("tap-widget"),
          onTap: () => widget.function(widget.categoryName, context),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 5, 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 0, 8),
                  child: Container(
                    width: 4,
                    height: hCard,
                    decoration: BoxDecoration(
                      color: Color(widget.category.colorValue),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 16, 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          widget.categoryName,
                          style: const TextStyle(
                            fontFamily: 'Outfit',
                            color: Color(0xFF101213),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: !constants.immutableCats
                          .contains(widget.categoryName)
                      ? [
                          IconButton(
                            tooltip: "Edit",
                            color: constants.mainBackColor,
                            icon: const Icon(Icons.mode_edit_outline_rounded),
                            onPressed: () => widget.moveToEditCatPage(
                                widget.categoryName, context),
                          ),
                          IconButton(
                            tooltip: "Remove",
                            color: Colors.redAccent,
                            icon: const Icon(Icons.delete_outline_rounded),
                            onPressed: () => widget.onDelete(context,
                                widget.removeCard, widget, "/categories"),
                          ),
                        ]
                      : [],
                ),
              ],
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
        height: hCard,
        fit: BoxFit.scaleDown,
      );
    });
  }
}
