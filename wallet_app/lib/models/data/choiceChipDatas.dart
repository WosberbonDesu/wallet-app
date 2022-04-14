
import 'package:flutter/material.dart';

import '../choiceChipData.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'Fatura',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
      iconName: "assets/fatura.png",
    ),
    ChoiceChipData(
      label: 'Yemek',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
      iconName: "assets/yemek.png",
    ),
    ChoiceChipData(
      label: 'Giyim',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
      iconName: "assets/giyim.png",
    ),
    ChoiceChipData(
      label: 'Kira',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
      iconName: "assets/kira.png",
    ),
    ChoiceChipData(
      label: 'Diğer',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
      iconName: "assets/diger.png",
    ),
  ];
}