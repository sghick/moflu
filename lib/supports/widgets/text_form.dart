import 'package:moflu/supports/styles/common_styles.dart';
import 'package:moflu/supports/widgets/count_down_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget underlineTextField(
    {String? hint,
    EdgeInsets? padding,
    Widget? suffixIcon,
    BoxConstraints? suffixConstraints,
    TextEditingController? controller,
    TextInputType? inputType,
    FormFieldValidator? validator,
    ValueChanged<String>? onChanged,
    Color? underLineColor,
    List<TextInputFormatter>? formatterList,
    int? maxLength}) {
  padding ??= EdgeInsets.only(left: 36.dp, right: 36.dp);
  underLineColor ??= Colors.green;
  formatterList ??= [];
  if (maxLength != null) {
    formatterList.add(LengthLimitingTextInputFormatter(maxLength));
  }

  var border =
      UnderlineInputBorder(borderSide: BorderSide(color: CBColors.lightGray));

  return Container(
    padding: padding,
    child: TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      onChanged: onChanged,
      inputFormatters: formatterList,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: newStyle.normalSize.lightGray.build,
        errorText: '',
        errorStyle: newStyle.smallSize.orange.height(1).build,
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        disabledBorder: border,
        focusedErrorBorder: border,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: underLineColor)),
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixConstraints,
      ),
    ),
  );
}

Widget captchaTextField(
  String? captchaKey, {
  String? hint,
  EdgeInsets? padding,
  CountDownButtonOnClick? onClick,
  TextEditingController? controller,
  TextInputType? inputType,
  FormFieldValidator? validator,
  ValueChanged<String>? onChanged,
  FocusNode? node,
}) {
  var suffix = CountDownButton(
    onClick: onClick,
    seconds: 60,
  );
  var suffixConstraint = BoxConstraints(maxWidth: 85.dp, maxHeight: 25.dp);

  return Stack(
    children: [
      underlineTextField(
        hint: hint,
        padding: padding,
        suffixIcon: SizedBox(),
        suffixConstraints: suffixConstraint,
        controller: controller,
        validator: validator,
        inputType: inputType,
        onChanged: onChanged,
      ),
      Container(
          margin: EdgeInsets.only(right: 52.dp),
          height: 43.dp,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: suffixConstraint,
                child: suffix,
              )
            ],
          )),
    ],
  );
}
