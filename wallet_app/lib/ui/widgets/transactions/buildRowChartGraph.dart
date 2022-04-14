import 'package:flutter/material.dart';
import '../../../business/styles/colors.dart';
import '../../../business/styles/text_styles.dart';


Row buildGraphLegend() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: PersonalColors.blue),
          ),
          const SizedBox(width: 8),
          const Text("Gelir")
        ],
      ),
      const SizedBox(width: 16),
      Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: PersonalColors.orange),
          ),
          const SizedBox(width: 8),
          const Text("Gider"),
        ],
      )
    ],
  );
}






