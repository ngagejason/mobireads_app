import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class StandardLoadingWidget extends StatefulWidget {

  const StandardLoadingWidget({Key? key}) : super(key: key);

  @override
  StandardLoadingWidgetState createState() => StandardLoadingWidgetState();
}

class StandardLoadingWidgetState extends State<StandardLoadingWidget>  {

  ReaderBloc? _readerBloc;

  @override
  void dispose() {
    _readerBloc?.ClearMessageReceiver();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getUI(context);
  }

  Widget getUI(BuildContext context){
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
