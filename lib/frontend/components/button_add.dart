import 'package:flutter/material.dart';

class ButtonAdd extends StatelessWidget {
  final String linkNav;
  final BuildContext pageContext;

  /// Creates an 'add button' that redirect you to [link] creation page
  ///
  /// 1-actual screen context
  ///
  /// 2-link to move
  ///
  const ButtonAdd(this.pageContext, this.linkNav, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 30, 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              pageContext,
              linkNav,
            );
          },
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 8,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
