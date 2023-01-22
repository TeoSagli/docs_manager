import 'package:docs_manager/frontend/components/widgets/loading_wheel.dart';
import 'package:flutter/material.dart';

const Color mainBackColor = Color.fromRGBO(75, 57, 239, 1);

final Widget defaultImg = Image.asset(
  "assets/images/Preview.png",
  height: 200,
  width: 200,
);

const Widget loadingWheel = SizedBox(
  width: 150,
  height: 150,
  child: MyLoadingWheel(),
);
const Widget loadingWheel2 = SizedBox(
  width: 100,
  height: 100,
  child: MyLoadingWheel(),
);

const emptyBox = SizedBox.shrink();

const imageQuality = 25;

const borderBottom = 15.0;

const immutableCats = [
  "Credit Cards",
  "IDs",
  "Other Cards",
  "Documents",
  "Pictures"
];

const alertDurAnimation = 3000;

const alertTextAlignment = TextAlign.left;
