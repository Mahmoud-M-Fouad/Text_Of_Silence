import 'package:flutter/material.dart';

class NoCategoriesSelectedDialog extends StatelessWidget {
  const NoCategoriesSelectedDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Categories Selected'),
      content: const Text('Please select at least a single category'),
      actions: <Widget>[
        FlatButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
