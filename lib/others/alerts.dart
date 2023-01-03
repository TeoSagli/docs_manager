import 'package:flutter/material.dart';

//========================================================
///Alert error during image upload
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
///Alert error during text fill
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
///Alert error element already existing
onErrorElementExisting(context, String elName) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Something went wrong!'),
      content: Text('$elName already existing!'),
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
///Alert error category already existing
onErrorFileExisting(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Something went wrong!'),
      content: const Text('File already existing!'),
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
///Alert success submit
onSuccess(context, path) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Success!'),
      content: const Text('Subit ended successfully!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, path),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

//========================================================
///Alert delete category
onDelete(context, deleteCategory, card, path) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Delete this category?'),
      content: const Text(
          'You are permanently deleting this category and all files contained in it. Do you confirm?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            deleteCategory(card);
            Navigator.pushNamed(context, path);
          },
          child: const Text(
            'Yes, delete this category',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    ),
  );
}

//========================================================
///Alert delete file
onDeleteFile(context, deleteCategory, card) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Delete this file?'),
      content:
          const Text('You are permanently deleting this file. Do you confirm?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            deleteCategory(card);
            Navigator.pop(context);
          },
          child: const Text(
            'Yes, delete this file',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    ),
  );
}

//========================================================
///Alert login confirmed
onLoginConfirmed(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Login confirmed'),
      content: const Text("Account successfully login"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

//========================================================
///Alert registration confirmed
onRegistrationConfirmed(context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Registration confirmed'),
      content: const Text("Account successfully registered"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

//========================================================
///Alert error firebase
onErrorFirebase(context, e) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('A problem occurred!'),
      content: Text(e.message.toString()),
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
///Alert error generic
onErrorGeneric(context, e) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('A problem occurred!'),
      content: Text(e.toString()),
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
