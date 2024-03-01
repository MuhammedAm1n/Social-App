import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const MyButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.primary),
        padding: EdgeInsets.all(25),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
