import 'package:flutter/material.dart';
import 'package:wallet_app/business/constants/colors.dart';




TextFormField buildTextField({

  required TextEditingController controller,
  required String? Function(String?) validator,
  IconData? iconData,
  Function? set,
  required String text,
  Function(String)? onChanged,
  bool isObscure = false,
  bool isPhoneNumber = false,
}) {
  return TextFormField(
    obscureText: isObscure,
    validator: validator,

    controller: controller,
    onChanged: onChanged,
    keyboardType: isPhoneNumber ? TextInputType.number : null,
    decoration: InputDecoration(
      focusColor: ColorConsts.textFormFieldColor,
        suffixIcon: IconButton(icon: Icon(iconData != null ? iconData : null),onPressed: (){
          set;
        },),
        border: OutlineInputBorder(borderSide: BorderSide(color: ColorConsts.textFormFieldColor)),


      hintText: text,
      labelText: text,
    ),
  );
}

