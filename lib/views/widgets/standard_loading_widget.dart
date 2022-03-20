import 'package:flutter/material.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class StandardLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(),

        CircularProgressIndicator(
          semanticsLabel: 'Loading...',
          color: FlutterFlowTheme.of(context).secondaryColor,
        )
      ],
    );
  }
}
