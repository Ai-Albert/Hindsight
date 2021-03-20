import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {

  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  SignInButton({
    this.color,
    this.text,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(this.color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))
          )),
        ),
        child: Text(
          this.text,
          style: TextStyle(
            color: this.textColor,
          ),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
