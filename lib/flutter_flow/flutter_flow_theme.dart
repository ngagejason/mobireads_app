import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
/*
// ignore: avoid_classes_with_only_static_members
class FlutterFlowTheme {
  static const Color primaryColor = Color(0xFF113e82);
  static const Color secondaryColor = Color(0xFFEACD29);
  static const Color tertiaryColor = Color(0xFFA7A7A7);

  String primaryFontFamily = 'Poppins';
  String secondaryFontFamily = 'Roboto';
  static TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  static TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  static TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  static TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF757575),
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  static TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF616161),
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  static TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF303030),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  static TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFF424242),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily = '',
    Color color = Colors.black,
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    bool useGoogleFonts = true
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle
            );
}
*/


abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => LightModeTheme();

  Color primaryColor = Color(0xFF062149); // Color(0x00008000);
  Color secondaryColor = Color(0xFFEACD29);
  Color tertiaryColor = Color(0xFFA7A7A7);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  TextStyle get title1 => GoogleFonts.getFont(
    'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  TextStyle get title2 => GoogleFonts.getFont(
    'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );
  TextStyle get title3 => GoogleFonts.getFont(
    'Poppins',
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  TextStyle get subtitle1 => GoogleFonts.getFont(
    'Poppins',
    color: Colors.white70,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  TextStyle get subtitle2 => GoogleFonts.getFont(
    'Poppins',
    color: Colors.white70,
    fontWeight: FontWeight.normal,
    fontSize: 16,
  );
  TextStyle get bodyText1 => GoogleFonts.getFont(
    'Poppins',
    color: Color(0xFF303030),
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
  TextStyle get bodyText2 => GoogleFonts.getFont(
    'Poppins',
    color: Color(0xFF424242),
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
}

class LightModeTheme extends FlutterFlowTheme {
  Color primaryColor = const Color(0xFF062149);
  Color secondaryColor = const Color(0xFFEACD29);
  Color tertiaryColor = const Color(0xFFA7A7A7);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String fontFamily = '',
    Color color = Colors.black,
    double? fontSize,
    FontWeight fontWeight = FontWeight.normal,
    FontStyle fontStyle = FontStyle.normal,
    bool useGoogleFonts = true
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
        fontFamily,
        color: color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle
      )
          : copyWith(
        fontFamily: fontFamily,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle
      );
}

