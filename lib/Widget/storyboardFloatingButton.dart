import 'package:flutter/material.dart';

class StoryboardFloaingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String heroTag;
  final Color backgroundColor;

  const StoryboardFloaingButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.heroTag,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      heroTag: heroTag,
      child: Icon(icon),
      backgroundColor: backgroundColor,
    );
  }
}
