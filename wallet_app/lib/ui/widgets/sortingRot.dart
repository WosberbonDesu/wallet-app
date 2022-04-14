import 'package:flutter/material.dart';

import '../../business/constants/sort_enums.dart';
import '../../business/styles/colors.dart';

Row buildSortingRow({required SortEnums value, required SortEnums sortValue}) {
  return Row(
    children: [
      Radio(
        value: value,
        groupValue: sortValue,
        activeColor: PersonalColors.orange,
        onChanged: (i) {},
      ),
      Text(value.rawValue),
    ],
  );
}