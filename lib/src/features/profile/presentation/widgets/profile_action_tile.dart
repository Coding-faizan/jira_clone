import 'package:flutter/material.dart';

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), onTap: onTap, leading: Icon(icon));
  }
}
