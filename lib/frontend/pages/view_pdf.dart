import 'package:docs_manager/frontend/components/contentPages/content_pdf_show.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PdfShow extends StatelessWidget {
  final String fName;
  final String cName;
  final String fIndex;
  const PdfShow(this.fName, this.cName, this.fIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('View pdf N° $fIndex', true, context),
      drawer: const MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
              hasScrollBody: false, child: ContentPdfShow(fName, cName, fIndex))
        ],
      ),
    );
  }
}
