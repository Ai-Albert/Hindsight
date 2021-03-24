import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {

  final Color color;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  final String logo;

  SignInButton({
    this.color,
    this.text,
    this.textColor,
    this.logo,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              child: Image.asset('${this.logo}'),
            ),
            Text(
              this.text,
              style: TextStyle(
                color: this.textColor,
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Image.asset('${this.logo}'),
              ),
            ),
          ],
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
