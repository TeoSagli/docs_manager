import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyCarousel extends StatefulWidget {
  final List<Image> imgList;
  final List<String>? extensions;
  final dynamic removeImg;
  final dynamic moveToOpenFile;
  final bool showRemove;
  final String? fileName;
  final String? catName;
  const MyCarousel(this.imgList, this.showRemove,
      {this.removeImg,
      this.extensions,
      this.moveToOpenFile,
      this.catName,
      this.fileName,
      super.key});

  @override
  State<StatefulWidget> createState() => MyCarouselState();
}

class MyCarouselState extends State<MyCarousel> {
  List<Widget> imageSliders = [constants.emptyBox];
  int currImgIndex = 0;
  @override
  void initState() {
    showCarousel();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyCarousel oldWidget) {
    showCarousel();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
      ),
      items: imageSliders,
    );
  }

  showCarousel() {
    setState(() {
      widget.imgList.isEmpty
          ? imageSliders = [constants.loadingWheel2]
          : imageSliders = widget.imgList.map((item) {
              currImgIndex = widget.imgList.indexOf(item);
              return Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      widget.imgList.elementAt(currImgIndex),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                'No. $currImgIndex image',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              widget.moveToOpenFile != null &&
                                      widget.extensions!
                                              .elementAt(currImgIndex) ==
                                          'pdf'
                                  ? IconButton(
                                      key: const Key("open-pdf"),
                                      color: constants.mainBackColor,
                                      onPressed: () => widget.moveToOpenFile(
                                          widget.fileName,
                                          widget.catName,
                                          currImgIndex),
                                      icon:
                                          const Icon(Icons.open_in_new_rounded),
                                    )
                                  : constants.emptyBox,
                            ],
                          ),
                        ),
                      ),
                      widget.showRemove == true
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                key: const Key("delete-pdf"),
                                color: Colors.redAccent,
                                icon: const Icon(Icons.delete_rounded),
                                onPressed: () => widget.removeImg(item),
                              ),
                            )
                          : constants.emptyBox
                    ],
                  ),
                ),
              );
            }).toList();
    });
  }
}
