import 'package:docs_manager/frontend/components/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/contentRegister.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('Register', true, context),
      body: const CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: ContentRegister(),
          )
        ],
      ),
    );
  }
}
