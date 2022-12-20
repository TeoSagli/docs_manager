import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  TextEditingController tc;
  final bool isTitle;

  ///My custom InputField:
  ///
  ///1-set the controller.
  ///
  ///2-set if it has a title limit of 20 characters.
  ///

  InputField(this.tc, this.isTitle, {super.key});

  @override
  State<StatefulWidget> createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      child: TextFormField(
        maxLength: widget.isTitle ? 20 : 50,
        controller: textController,
        autofocus: false,
        obscureText: false,
        decoration: InputDecoration(
          hintText: 'Put here text',
          hintStyle: const TextStyle(
            fontFamily: 'Outfit',
            color: Color(0xFF090F13),
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        ),
        //body>title1
        style: const TextStyle(
          fontFamily: 'Outfit',
          color: Color(0xFF090F13),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        onChanged: (value) {
          widget.tc.text = textController.text;
        },
        textAlign: TextAlign.start,
      ),
    );
  }
}
