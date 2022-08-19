import 'package:flutter/material.dart';

class PickImageButton extends StatelessWidget {
  PickImageButton({required this.btnText, required this.btnIcon, required this.onPressed});

  final String btnText;
  final IconData btnIcon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: MaterialButton(
        color: Colors.black87,
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(
                btnIcon,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(width: 20),
              Text(btnText, style: TextStyle(fontSize: 18, color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
