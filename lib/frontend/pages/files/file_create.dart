import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_function.dart';
import 'package:docs_manager/frontend/components/button_icon_function.dart';
import 'package:docs_manager/frontend/components/dropdown_menu.dart';
import 'package:docs_manager/frontend/components/image_network.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:docs_manager/frontend/components/title_text.dart';
import 'package:flutter/material.dart';

class FileCreatePage extends StatefulWidget {
  const FileCreatePage({super.key});

  @override
  State<StatefulWidget> createState() => FileCreateState();
}

class FileCreateState extends State<FileCreatePage> {
  Widget widgetChanging = const ImageFromNetwork(
      Colors.white,
      'https://media.istockphoto.com/id/1206044836/vector/preview-stamp-preview-round-vintage-grunge-sign-preview.jpg?s=612x612&w=0&k=20&c=SSZ0NLA7Bsv3Zlq_9DhalidL0Fc2ofhF7BCq2vjcNwc=',
      150,
      150);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController2 = TextEditingController();
    TextEditingController textController1 = TextEditingController();
    return Scaffold(
      appBar: MyAppBar("File creation", true, context),
      bottomNavigationBar: MyBottomBar(context, 4),
      body: Stack(
        children: [
          SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, -0.9),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 30, 10, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, -0.9),
                                        child: Column(
                                          children: [
                                            const TitleText(
                                                "Document name:", Colors.black),
                                            InputField(textController1),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 10, 10, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            const TitleText(
                                                "Add document from:",
                                                Colors.black),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(8, 8, 8, 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  MyButtonIcon(
                                                      'CAMERA',
                                                      doStuff,
                                                      Icons.photo_camera),
                                                  MyButtonIcon('GALLERY',
                                                      doStuff, Icons.image),
                                                  MyButtonIcon(
                                                      'PDF, TXT....',
                                                      doStuff,
                                                      Icons.picture_as_pdf),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                //==================================WIDGET PDF PREVIEW
                                                Stack(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          1, -1),
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              1, 0),
                                                      child: widgetChanging,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0, 0),
                                                      child: IconButton(
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      const Size(
                                                                          60,
                                                                          60)),
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        icon: const Icon(
                                                          Icons.delete,
                                                          color:
                                                              Color(0xFFFF0000),
                                                          size: 30,
                                                        ),
                                                        onPressed: () {
                                                          print(
                                                              'IconButton pressed ...');
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                //==================================WIDGET PDF PREVIEW
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1, -1),
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                1, 0),
                                                        child: widgetChanging),
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              0, 0),
                                                      child: IconButton(
                                                        style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      const Size(
                                                                          60,
                                                                          60)),
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              side:
                                                                  const BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color:
                                                              Color(0xFFFF0000),
                                                          size: 30,
                                                        ),
                                                        onPressed: () {
                                                          print(
                                                              'IconButton pressed ...');
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                //==================================
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  //==================================WIDGET CATEGORIES CHOICE
                                  //  const MyDropdown(),
                                  //==================================
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 30, 10, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const TitleText(
                                            '(Optional) field', Colors.black),
                                        InputField(textController2)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyButton('Submit', onSubmit),
              ]),
        ],
      ),
    );
  }

  doStuff() {}
  onSubmit() {}
}
