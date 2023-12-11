import 'package:flutter/material.dart';

const kPrimaryColor = Colors.black;
const kBgWhite = Color(0xFFfafafa);
const kBgBlack = Color(0xFF191508);
const kGrey = Color(0xFF595959);
const kInactiveColor = Color(0xFFa6a6a6);
const kDefaultPicture = 'assets/images/default_picture.jpeg';
const kDefaultFastDuration = Duration(milliseconds: 250);
const kDefaultDuration = Duration(milliseconds: 500);
const kDefaultCurve = Curves.easeInOutCirc;

TextStyle get kDefaultTextStyle {
  return TextStyle(
    color: kBgBlack,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
}
