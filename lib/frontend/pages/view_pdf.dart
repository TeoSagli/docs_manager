import 'package:docs_manager/frontend/components/contentPages/content_pdf_show.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PdfShow extends StatelessWidget {
  final ContentPdfShow content;
  final MyAppBar myAppBar;
  final MyDrawer myDrawer;

  const PdfShow(this.content, this.myAppBar, this.myDrawer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: myAppBar,
      drawer: myDrawer,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(hasScrollBody: false, child: content),
        ],
      ),
    );
  }
}
