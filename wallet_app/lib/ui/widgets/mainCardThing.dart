import 'package:flutter/material.dart';
import 'package:wallet_app/business/styles/colors.dart';

import '../../business/styles/text_styles.dart';



buildTransactionCard(String icon, String cardName,String dateTime,String valueGiven,Color color) {
  return Container(
    color: Color(0xFFF9F9F9),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          color: Colors.white,
          child: IconButton(icon: Image.asset(icon),color: PersonalColors.orange,onPressed: (){},),
        ),
        const SizedBox(width: 20),
        Expanded(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                cardName,
                style: PersonalTStyles.w600s14B,
              ),
              const SizedBox(height: 5),
              Text(
                dateTime,
                style: PersonalTStyles.w400s12G1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Text(
            valueGiven,style: TextStyle(color: color),
        ),
      ],
    ),
  );
}