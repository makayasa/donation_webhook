import 'package:flutter/material.dart';

import 'constant.dart';

class DefText {
  final String text;
  final Color color;
  final double opacity;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final int? maxLine;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final Key? key;
  final TextStyle? customStyle;

  DefText(
    this.text, {
    this.maxLine,
    this.color = kBgBlack,
    this.opacity = 1,
    this.fontStyle,
    this.fontWeight,
    this.textAlign,
    this.decoration,
    this.key,
    this.customStyle,
  });

  TextStyle get _style {
    if (customStyle == null) {
      return kDefaultTextStyle.copyWith(
        color: color.withOpacity(opacity),
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: decoration,
      );
    } else {
      return customStyle!.copyWith(
        color: color.withOpacity(opacity),
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: decoration,
      );
    }
  }

  Text get mini {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 8.9),
    );
  }

  Text get extraSmall {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 9.7),
    );
  }

  Text get small {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 10.7),
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
    );
  }

  Text get semiSmall {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 11.7),
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
    );
  }

  Text get normal {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 12.7),
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
    );
  }

  Text get semilarge {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 15.7),
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
    );
  }

  Text get large {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 17.7),
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
    );
  }

  Text get extraLarge {
    return Text(
      text,
      key: key,
      maxLines: maxLine,
      textAlign: textAlign,
      style: _style.copyWith(fontSize: 22.7),
      overflow: maxLine != null ? TextOverflow.ellipsis : null,
    );
  }
}
