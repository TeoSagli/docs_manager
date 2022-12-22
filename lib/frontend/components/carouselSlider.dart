import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:docs_manager/others/constants.dart' as constants;

class MyCarousel extends StatefulWidget {
  final List<Image> imgList;
  final dynamic removeImg;
  const MyCarousel(this.imgList, this.removeImg, {super.key});

  @override
  State<StatefulWidget> createState() => MyCarouselState();
}

class MyCarouselState extends State<MyCarousel> {
  List<Widget> imageSliders = [constants.emptyBox];
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
      ),
      items: imageSliders,
    );
  }

  showCarousel() {
    setState(() {
      imageSliders = widget.imgList
          .map((item) => Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        item,
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
                            child: Text(
                              'No. ${widget.imgList.indexOf(item) + 1} image',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            color: Colors.redAccent,
                            icon: const Icon(Icons.delete_rounded),
                            onPressed: () => widget.removeImg(item),
                          ),
                        ),
                      ],
                    )),
              ))
          .toList();
    });
  }
}
