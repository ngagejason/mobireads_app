import 'package:flutter/material.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class StandardInputs {
  static TextFormField getStandardTextInput({
    required BuildContext buildContext,
    String? hintText,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
    String? initialValue
  }) {

    return TextFormField(
        obscureText: false,
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: FlutterFlowTheme.of(buildContext).bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black54,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Color(0xD3FFFFFF),
          contentPadding: EdgeInsetsDirectional.fromSTEB(
              16, 10, 0, 24),
        ),
        style: FlutterFlowTheme.of(buildContext).bodyText1.override(
          fontFamily: 'Poppins',
          color: Color(0xFF2B343A),
        ),
        validator: validator,
        onChanged: onChanged
    );
  }

  static TextFormField getStandardPasswordInput({
    required BuildContext buildContext,
    String? hintText,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
    void Function()? onPasswordVisibilityTapped,
    bool passwordVisibility = false}) {

    return TextFormField(
        obscureText: !passwordVisibility,
        decoration: InputDecoration(
          hintText: 'Enter your password here...',
          hintStyle: FlutterFlowTheme.of(buildContext).bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.black54
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Color(0xD3FFFFFF),
          contentPadding: EdgeInsetsDirectional.fromSTEB(
              16, 10, 0, 24),
          suffixIcon: InkWell(
            onTap: onPasswordVisibilityTapped,
            child: Icon(
              passwordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Color(0xFF95A1AC),
              size: 22,
            ),
          ),
        ),
        style: FlutterFlowTheme.of(buildContext).bodyText1.override(
          fontFamily: 'Poppins',
          color: Color(0xFF2B343A),
        ),
        validator: validator,
        onChanged: onChanged
    );
  }

  static TextFormField getStandardUsernameInput({
    required BuildContext buildContext,
    String? hintText,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
    bool passwordVisibility = false,
    bool isLoading = false,
    bool usernameNotAvailable = false,
    bool usernameConfirmed = false}) {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'Enter your username here...',
          hintStyle: FlutterFlowTheme.of(buildContext).bodyText1.override(
              fontFamily: 'Poppins',
              color: Colors.black54
          ),
          suffix: SizedBox(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0,0,10,0),
              child: getStandardUsernameInputSuffix(isLoading, usernameConfirmed, usernameNotAvailable),
            ),
            height: 20.0,
            width: 30.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Color(0xD3FFFFFF),
          contentPadding: EdgeInsetsDirectional.fromSTEB(
              16, 10, 0, 24),
        ),
        style: FlutterFlowTheme.of(buildContext).bodyText1.override(
          fontFamily: 'Poppins',
          color: Color(0xFF2B343A),
        ),
        validator: validator,
        onChanged: onChanged
    );
  }

  static Widget getStandardUsernameInputSuffix(bool isLoading, bool usernameConfirmed, bool usernameNotAvailable){
    if(isLoading){
      return SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0,0,0,0),
          child: CircularProgressIndicator(),
        ),
        height: 25.0,
        width: 25.0,
      );
    }
    else if(!usernameConfirmed && !usernameNotAvailable)
      return Container();
    else if(!usernameConfirmed)
      return Icon(Icons.error_outline, color: Colors.red, size: 20.0);
    else
      return Icon(Icons.check, color: Colors.green, size: 20.0);
  }
}
