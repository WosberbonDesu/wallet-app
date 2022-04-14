import 'package:flutter/material.dart';
import 'package:wallet_app/business/constants/colors.dart';
import 'package:wallet_app/business/styles/colors.dart';
import 'package:wallet_app/ui/widgets/gradient_text.dart';
import '../../business/styles/text_styles.dart';


class AuthPageTemplate extends StatelessWidget {
  const AuthPageTemplate({Key? key, required this.page, this.profilePicWidget})
      : super(key: key);

  final Widget page;
  final Widget? profilePicWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/top.png",
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height * 0.38,
                ),
                profilePicWidget ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage("https://images.unsplash.com/photo-1586374579358-9d19d632b6df?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80"),

                        ),

                         GradientText(
                          "E-Cüzdan",
                          gradient: LinearGradient(colors: [
                            ColorConsts.justRed,
                            ColorConsts.mainBlue,
                            ColorConsts.successColor,
                            ColorConsts.oceanBlue,
                            PersonalColors.lightOrange,
                          ]),
                          style: PersonalTStyles.w600s32W,
                        )
                      ],
                    )
              ],
            ),
            Positioned(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.38 - 50),
                padding: const EdgeInsets.only(top: 44, right: 24, left: 24),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}