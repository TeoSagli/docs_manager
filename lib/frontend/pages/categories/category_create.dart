import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/bottom_bar.dart';
import 'package:docs_manager/frontend/components/button_submit.dart';
import 'package:docs_manager/frontend/components/button_upload_image.dart';
import 'package:docs_manager/frontend/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/image_network.dart';
import '../../components/title_text.dart';

import 'package:docs_manager/others/constants.dart' as constants;

class CategoryCreatePage extends StatefulWidget {
  const CategoryCreatePage({Key? key}) : super(key: key);

  @override
  _CategoryCreateWidgetState createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreatePage> {
  late final ImagePicker picker = ImagePicker();
  late final XFile? imageGallery;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: MyBottomBar(context, 4),
      appBar: MyAppBar('Create a Category', true, context),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const InputField(),
              const ButtonUploadImage(),
              ButtonSubmit(context, onSubmit)
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(context) {}
}
