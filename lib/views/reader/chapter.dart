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

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return getGestureContainer(context);
  }

  Widget getHtml(BuildContext context){
    return Html(
      key: key,
      data: writing,

      customRender: {
        "span": (RenderContext context, Widget child) {
          var fs =  min(max(selectedFontSize * (context.style.fontSize?.size ?? FontSizes.DEFAULT_FONT_SIZE), FontSizes.MIN_FONT_SIZE), FontSizes.MAX_FONT_SIZE);
          if(context.style.fontSize != null){
            context.style.fontSize = FontSize(fs);
            context.style.lineHeight = LineHeight(1.5);
            context.style.fontFamily = 'Poppins';
          }
          else{
            context.style.fontSize = FontSize(selectedFontSize * FontSizes.DEFAULT_FONT_SIZE);
            context.style.lineHeight = LineHeight(1.5);
            context.style.fontFamily = 'Poppins';
          }
        },
        "p": (RenderContext context, Widget child) {
          var fs =  min(max(selectedFontSize * (context.style.fontSize?.size ?? FontSizes.DEFAULT_FONT_SIZE), FontSizes.MIN_FONT_SIZE), FontSizes.MAX_FONT_SIZE);
          if(context.style.fontSize != null){
            context.style.fontSize = FontSize(fs);
            context.style.lineHeight = LineHeight(1.5);
            context.style.fontFamily = 'Poppins';
          }
          else{
            context.style.fontSize = FontSize(selectedFontSize * FontSizes.DEFAULT_FONT_SIZE);
            context.style.lineHeight = LineHeight(1.5);
            context.style.fontFamily = 'Poppins';
          }
        },
        "em": (RenderContext context, Widget child) {
          var fs =  min(max(selectedFontSize * (context.style.fontSize?.size ?? FontSizes.DEFAULT_FONT_SIZE), FontSizes.MIN_FONT_SIZE), FontSizes.MAX_FONT_SIZE);
          if(context.style.fontSize != null){
            context.style.fontSize = FontSize(fs);
            context.style.lineHeight = LineHeight(1.5);
            context.style.fontFamily = 'Poppins';
          }
          else{
            context.style.fontSize = FontSize(selectedFontSize * FontSizes.DEFAULT_FONT_SIZE);
            context.style.lineHeight = LineHeight(1.5);
            context.style.fontFamily = 'Poppins';
          }
        }
      },
    );
  }

  Widget getGestureContainer(BuildContext context){
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
                      Flexible(
                          child: Text(
                            widget.chapter?.Title ?? '',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                fontSize:  min(max(selectedFontSize * FontSizes.DEFAULT_TITLE_SIZE, FontSizes.MIN_FONT_SIZE), FontSizes.MAX_FONT_SIZE)
                            ),
                          )
                      )
                    ]
                ),
              ),
              getHtml(context)
            ],
          )
      ),
    );
  }
}