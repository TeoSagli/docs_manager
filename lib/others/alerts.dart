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
//Alert delete category
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
