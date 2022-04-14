import 'package:flutter/material.dart';
import 'package:wallet_app/business/styles/colors.dart';


class ProfilePic extends StatelessWidget {
  const ProfilePic({
    required this.firebaseImUrl,
    Key? key,
  }) : super(key: key);
  final String firebaseImUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
           CircleAvatar(
            backgroundColor: Colors.blueGrey,
            backgroundImage:  NetworkImage(firebaseImUrl!),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: const Icon(Icons.add_a_photo_outlined,color: PersonalColors.orange,),
              ),
            ),
          )
        ],
      ),
    );
  }
}