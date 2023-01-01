import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class ReaderLoadingWidget extends StatefulWidget {

  const ReaderLoadingWidget({Key? key}) : super(key: key);

  @override
  ReaderLoadingWidgetState createState() => ReaderLoadingWidgetState();
}

class ReaderLoadingWidgetState extends State<ReaderLoadingWidget>  {

  ReaderBloc? _readerBloc;
  String? _message;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      this.setState(() {
        _readerBloc = context.read<ReaderBloc>();
        _readerBloc?.SetMessageReceiver(this.setMessage);
      });
    });
  }

  @override
  void dispose() {
    _readerBloc?.ClearMessageReceiver();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getUI(context);
  }

  void setMessage(String message){
    setState(() {
      _message = message;
    });
  }

  Widget getUI(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(),
        CircularProgressIndicator(
          color: FlutterFlowTheme.of(context).secondaryColor,
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text(
            _message ?? 'Loading...',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryColor,
              fontSize: 20,
            ),
          ),
        )
      ],
    );
  }
}
