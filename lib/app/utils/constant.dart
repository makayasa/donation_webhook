import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

const kPrimaryColor = Color(0XFFF3EEEA);
const kSecondaryColor = Color(0XFFEBE3D5);

const kThirdColor = Color(0xFFB0A695);
const kFourthColor = Color(0xFF776B5D);
const kBgWhite = Color(0xFFfafafa);
const kBgBlack = Color(0xFF191508);
const kGrey = Color(0xFF595959);
const kInactiveColor = Color(0xFFa6a6a6);
const kDefaultPicture = 'assets/images/default_picture.jpeg';
const kDefaultFastDuration = Duration(milliseconds: 250);
const kDefaultDuration = Duration(milliseconds: 500);
const kDefaultCurve = Curves.easeInOutCirc;

TextStyle get kDefaultTextStyle {
  return const TextStyle(
    color: kBgBlack,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
}

final logger = Logger(
  printer: kDefaultPrettyPrinter,
);

final kDefaultPrettyPrinter = PrettyPrinter(
  methodCount: 2,
  errorMethodCount: 3,
  lineLength: 120,
  dateTimeFormat: DateTimeFormat.dateAndTime,
  levelColors: {
    Level.trace : const AnsiColor.fg(250),
    Level.info: const AnsiColor.fg(217)
  },
);

const kScreenChangePoint = ResponsiveScreenSettings(
  desktopChangePoint: 850,
  tabletChangePoint: 500,
  watchChangePoint: 320,
);

const kDefaultBorderRadius10 = BorderRadius.all(
  Radius.circular(10),
);
const kDefaultBorderRadius = BorderRadius.all(
  Radius.circular(5),
);

const kTuyaTokenMap = 'tuya_map';

const kTuyaAccessToken = 'access_token';
const kTuyaRefreshToken = 'refresh_token';
const kTuyaExpireTime = 'expire_time';
const kTuyaCreatedTime = 'created_time';
// const kTuyaRefreshToken = 'tuya_refresh_token';

const kValorantMode = 'valorant_mode';
const kEldenRingMode = 'elden_ring_mode';
