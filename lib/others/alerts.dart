import 'package:flutter/material.dart';

//========================================================
//Alert error during image upload
onErrorImage(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Something went wrong!'),
      content: const Text('Upload an image for your category!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

//========================================================
//Alert error during text fill
onErrorText(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Something went wrong!'),
      content: const Text('Text cannot be empty!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

//========================================================
//Alert error category already exixsting
onErrorCategoryExisting(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Something went wrong!'),
      content: const Text('Category already existing!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

//========================================================
//Alert success submit
onSuccess(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Success!'),
      content: const Text('Subit ended successfully!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/categories'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
//========================================================