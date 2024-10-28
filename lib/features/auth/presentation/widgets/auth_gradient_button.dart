import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final String textName;
  const AuthGradientButton({super.key, required this.textName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(colors: [
          AppPallete.gradient1,
          AppPallete.gradient2,
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          fixedSize: Size(395, 55),
        ),
        child: Text(
          textName,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}