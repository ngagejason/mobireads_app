import 'package:flutter/material.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class ErrorSnackbar extends StatelessWidget {
  ErrorSnackbar({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Oops!',
          textAlign: TextAlign.center,
          style: FlutterFlowTheme.of(context).bodyText1.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.of(context).secondaryColor,
            fontSize: 30,
          ),
        ),
        /*Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
          child: Text(
            'Something went wrong',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.of(context).secondaryColor,
              fontSize: 20,
            ),
          ),
        ),*/
        Divider(
          indent: 20,
          endIndent: 20,
          color: FlutterFlowTheme.of(context).tertiaryColor,
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 20),
          child: Text(
            this.message,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.of(context).secondaryColor,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}
