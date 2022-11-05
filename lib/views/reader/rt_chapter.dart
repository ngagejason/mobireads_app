import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;  // that is

class RTChapterWidget extends StatefulWidget {
  final OutlineChapter? chapter;
  const RTChapterWidget({Key? key, required this.chapter}) : super(key: key);

  @override
  _RTChapterWidgetState createState() => _RTChapterWidgetState();
}

class _RTChapterWidgetState extends State<RTChapterWidget> {

  late ReaderBloc _readerBloc;
  GlobalKey key = GlobalKey(debugLabel: '_html');
  String writing = '';
  bool disposeCalled = false;
  double selectedFontSize = 0;

  @override
  void initState() {
    super.initState();
    _readerBloc = context.read<ReaderBloc>();
    _readerBloc.AddSetState(widget.chapter?.Id ?? '', doSetState);
    writing = widget.chapter?.Writing ?? '';
    selectedFontSize = _readerBloc.currentFontSize;
    disposeCalled = false;
  }

  @override
  void dispose() {
    disposeCalled = true;
    _readerBloc.RemoveSetState(widget.chapter?.Id ?? '');
    super.dispose();
  }

  void doSetState(String? a, double? fontSize){
    if(!disposeCalled){
      var state = () {
        key = new GlobalKey();
        writing = a ?? writing;
        selectedFontSize = fontSize ?? selectedFontSize;
      };

      setState(state);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: 'Hello', // default text style
        style: TextStyle(color: Colors.white),
        children: <TextSpan>[
          TextSpan(text: ' beautiful ', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic)),
          TextSpan(text: 'world\n', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextSpan(text: 'this is a test to see what happens ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextSpan(text: 'when the text ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          TextSpan(text: 'is long and I want to know if it will wrap ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
      onSelectionChanged: (TextSelection selection, SelectionChangedCause? cause) {
        print('here');
        print('start = ' + selection.start.toString());
        print('end = ' + selection.end.toString());
        print('baseOffset = ' + selection.baseOffset.toString());
        print('extentOffset = ' + selection.extentOffset.toString());
        print('cause.index ' + cause!.index.toString());
        print('------------------');
      },
    );
  }
}