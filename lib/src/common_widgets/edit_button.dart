import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: onPressed,
      color: Colors.blue,
    );
  }
}
