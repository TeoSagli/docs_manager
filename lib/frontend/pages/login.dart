import 'package:docs_manager/backend/update_db.dart';
import 'package:docs_manager/frontend/components/widgets/app_bar.dart';
import 'package:docs_manager/frontend/components/contentPages/content_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final ContentLogin content;
  final MyAppBar myAppBar;
  const LoginPage(this.content, this.myAppBar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar('Login', false, context, false, Navigator.pop,
          Navigator.pushNamed, updateUserLogutStatus),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: content,
          )
        ],
      ),
    );
  }
}
