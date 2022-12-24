import 'package:docs_manager/frontend/components/image_network.dart';
import 'package:docs_manager/frontend/components/loading_wheel.dart';
import 'package:flutter/material.dart';

const Color mainBackColor = Color.fromRGBO(75, 57, 239, 1);

const Widget defaultImg = ImageFromNetwork(
    Colors.white,
    'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
    200,
    200);

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

const Widget emptyPage = Align(
  alignment: Alignment.center,
  child: Text(
    "Page is empty",
    style: TextStyle(color: mainBackColor, fontSize: 20),
  ),
);

const emptyBox = SizedBox.shrink();

const imageQuality = 50;
