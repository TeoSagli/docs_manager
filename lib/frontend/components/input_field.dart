import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  TextEditingController tc;

  ///My custom InputField:
  ///
  ///1-set the controller.
  ///

  InputField(this.tc, {super.key});

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
        controller: textController,
        autofocus: true,
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
