import 'package:flutter/material.dart';

void ShowSnacbar(BuildContext context, String conent) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(conent),
      ),
    );
}
