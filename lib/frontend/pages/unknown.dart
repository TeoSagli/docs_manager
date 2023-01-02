import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('Register', true, context),
      body: const CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text("Error 404: Page not found!")),
          )
        ],
      ),
    );
  }
}
