import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/entities/outline_chapters/OutlineChapter.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';
import 'package:flutter_html/flutter_html.dart';

class ChapterWidget extends StatefulWidget {
  final OutlineChapter? chapter;
  const ChapterWidget({Key? key, required this.chapter}) : super(key: key);

  @override
  _ReaderPageWidgetState createState() => _ReaderPageWidgetState();
}

class _ReaderPageWidgetState extends State<ChapterWidget> {

  late ReaderBloc _readerBloc;
  GlobalKey key = GlobalKey(debugLabel: '_html');
  String writing = '';
  bool disposeCalled = false;
  @override
  void initState() {
    super.initState();
    _readerBloc = context.read<ReaderBloc>();
    _readerBloc.AddSetState(widget.chapter?.Id ?? '', doSetState);
    writing = widget.chapter?.Writing ?? '';
    disposeCalled = false;
  }

  void doSetState(String a){
    if(!disposeCalled){
      setState(() {
        writing = a;
        key = new GlobalKey();
      });
    }
  }

  @override
  void dispose() {
    disposeCalled = true;
    _readerBloc.RemoveSetState(widget.chapter?.Id ?? '');
    super.dispose();
  }


  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child:
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 0, 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text(
                        widget.chapter?.Title ?? '',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      )
                    ]
                ),
              ),
              Html(key: key, data: writing),
            ],
          )
      ),
    );
  }
}


