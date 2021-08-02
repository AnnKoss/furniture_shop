import 'package:flutter/material.dart';

class DefaultAlertDialog extends StatelessWidget {
  final String text;
  DefaultAlertDialog(this.text);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ошибка'),
      content: Text(text),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Закрыть'),
        ),
      ],
    );
  }
}
