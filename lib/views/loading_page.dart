import 'package:flutter/material.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return (
      Container(
        color: FlutterFlowTheme.of(context).primaryColor,
        child:       Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Loading...',
                  color: FlutterFlowTheme.of(context).secondaryColor,
                )
            )
          ],
        ),
      )
    );
  }
}