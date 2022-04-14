import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet_app/business/constants/colors.dart';
import 'package:wallet_app/business/styles/colors.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.colorIcon,
    required this.colorArrow,
    required this.textButtonColor,
    this.press,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color colorIcon;
  final Color colorArrow;
  final Color textButtonColor;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          primary: Colors.blueGrey,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: textButtonColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: colorIcon,
              size: 22,
            ),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: colorIcon),
            )),
            Icon(
              Icons.arrow_forward_ios,
              color: colorArrow,
            ),
          ],
        ),
      ),
    );
  }
}
