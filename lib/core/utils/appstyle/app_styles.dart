import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rehana_dashboared/core/utils/appstyle/size_config.dart';
import '../font/fonts.dart';

abstract class AppStyles {
  static TextStyle styleRegular16(context) {
    return TextStyle(
      fontFamily: Fonts.font,
      color: const Color(0xFF064060),
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styletitlelogin(BuildContext context){
    return TextStyle(
      fontFamily: Fonts.font,
      fontSize: getResponsiveFontSize(context, fontSize:24),
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }


  static TextStyle styleLogin(BuildContext context) {
    return TextStyle(
      fontFamily: Fonts.font,
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textformfieldstyle(BuildContext context) {
    return TextStyle(
      fontFamily: Fonts.font,
      fontSize: getResponsiveFontSize(context, fontSize: 13),
      fontWeight: FontWeight.w700,
      color: Color(0xff949494),
    );
  }

  static TextStyle buttonstyle(BuildContext context, Color color) {
    return TextStyle(
      fontFamily: Fonts.font,
      color: color,
      fontSize: getResponsiveFontSize(context, fontSize: 15),
      fontWeight: FontWeight.w700,
    );
  }
}

double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  var dispatcher = PlatformDispatcher.instance;
  var physicalWidth = dispatcher.views.first.physicalSize.width;
  var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  double width = physicalWidth / devicePixelRatio;

  // double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else if (width < SizeConfig.desktop) {
    return width / 1000;
  } else {
    return width / 1920;
  }
}
