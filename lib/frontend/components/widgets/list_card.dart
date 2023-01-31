import 'package:docs_manager/backend/models/category.dart';
import 'package:docs_manager/backend/models/file.dart';
import 'package:docs_manager/frontend/components/widgets/loading_wheel.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class ListCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListCardState();
  final String fileName;
  final FileModel file;
  final dynamic function;
  final dynamic moveToEditFilePage;
  final dynamic removeCard;
  final dynamic updateFavouriteDB;
  final dynamic onDeleteFile;
  final dynamic readImageCategoryStorage;
  final dynamic getCatModelFromCatNameDB;

  const ListCard(
      this.fileName,
      this.file,
      this.function,
      this.moveToEditFilePage,
      this.removeCard,
      this.updateFavouriteDB,
      this.onDeleteFile,
      this.readImageCategoryStorage,
      this.getCatModelFromCatNameDB,
      {super.key});
}

class ListCardState extends State<ListCard> {
  Widget cardImage = const SizedBox(
    width: 30,
    height: 30,
    child: MyLoadingWheel(),
  );
  late bool isFav;
  Color catColor = Colors.grey;
  CategoryModel catMod =
      CategoryModel(path: "", nfiles: 0, colorValue: 0, order: 0);

  @override
  void initState() {
    if (mounted) {
      String ext = "";
      if (constants.immutableCats.contains(widget.file.categoryName)) {
        ext = "png";
      } else {
        ext = widget.file.extension.elementAt(0) as String;
      }
      setState(() {
        isFav = widget.file.isFavourite;
        widget.getCatModelFromCatNameDB(setCatMod, widget.file.categoryName);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
      child: MouseRegion(
        child: GestureDetector(
          key: const Key("move-to"),
          onTap: () => widget.function(widget.fileName, context),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x25000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? const EdgeInsets.fromLTRB(10, 0, 0, 0)
                                : const EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: cardImage),
                        SizedBox(
                          width: 100,
                          child: Text(
                            widget.fileName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          key: const Key("move-to-2"),
                          color: constants.mainBackColor,
                          icon: const Icon(Icons.mode_edit_outline_rounded),
                          onPressed: () => widget.moveToEditFilePage(
                              widget.fileName, context),
                        ),
                        IconButton(
                            key: const Key("set-fav"),
                            color: constants.mainBackColor,
                            icon: Icon(isFav
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded),
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                              widget.updateFavouriteDB(widget.file.categoryName,
                                  widget.fileName, isFav);
                            }),
                        IconButton(
                          key: const Key("tap-del"),
                          color: Colors.redAccent,
                          icon: const Icon(Icons.delete_rounded),
                          onPressed: () => widget.onDeleteFile(
                              context, widget.removeCard, widget),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //========================================================
  setCard(d) {
    if (mounted) {
      setState(() {
        cardImage =
            Image.memory(d!, fit: BoxFit.cover, cacheHeight: 100, height: 30);
      });
    }
  }

  //========================================================
  setCatMod(c) {
    if (mounted) {
      setState(() {
        catMod = c;
      });

      widget.readImageCategoryStorage(catMod.path, setCard);
    }
  }
  //========================================================
}
