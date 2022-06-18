import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class ReaderSettingsSnackbar extends StatelessWidget {
  ReaderSettingsSnackbar({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    var readerBloc = context.read<ReaderBloc>();

    return BlocBuilder<ReaderBloc, ReaderState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [

          /*Text(
            'Font Size',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyText1.override(
              fontFamily: 'Poppins',
              color: FlutterFlowTheme.of(context).secondaryColor,
              fontSize: FontSizes.DEFAULT_FONT_SIZE,
            ),
          ),
          Slider(
            value: FontSizes.DEFAULT_FONT_SIZE,
            min: 10,
            max: 30,
            divisions: 10,
            onChanged: (double value) {
              readerBloc.add(FontSizeChanged(value));
            },
          ),
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
          )*/
        ],
      );
    });
  }
}
