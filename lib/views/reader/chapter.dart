import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
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
  double selectedFontSize = 30;

  @override
  void initState() {
    super.initState();
    _readerBloc = context.read<ReaderBloc>();
    _readerBloc.AddSetState(widget.chapter?.Id ?? '', doSetState);
    writing = widget.chapter?.Writing ?? '';
    selectedFontSize = _readerBloc.state.fontSize ?? 14;
    disposeCalled = false;
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
/*
  CustomRenderMatcher birdMatcher() => (context) {
    return context.tree.element?.localName == 'bird';
  };

  CustomRenderMatcher flutterMatcher() => (context) {
    return context.tree.element?.localName == 'flutter';
  };

  CustomRenderMatcher modifyFontSize() => (context) {
    return context.style.fontSize != null && context.style.fontSize?.size != null && context.style.fontSize?.size != selectedFontSize;
  };*/

  double GetFontSize(double existingFontSize){
    return existingFontSize + ((_readerBloc.state.fontSize ?? FontSizes.DEFAULT_FONT_SIZE)  - FontSizes.DEFAULT_FONT_SIZE);
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
                            fontSize: selectedFontSize + 5
                        ),
                      )
                    ]
                ),
              ),
              Html(
                key: key,
                data: writing,
                style: {
                  "span": Style(
                    fontSize: FontSize(selectedFontSize),
                  )
                },
               /* customTextStyle: (dom.Node node, TextStyle baseStyle) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "p":
                        return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
                    }
                  }
                  return baseStyle;
                },*/

                customRender: {

                  "span": (RenderContext context, Widget child) {
                    return child;
                  },
                  /*
                  tagMatcher("span"): CustomRender.inlineSpan(inlineSpan: (context, buildChildren) =>
                    TextSpan(
                      style: TextStyle(
                        color: context.style.color ?? Colors.black,
                        fontSize: context.style.fontSize != null ?
                        GetFontSize(context.style.fontSize?.size ?? FontSizes.DEFAULT_FONT_SIZE) :
                        GetFontSize(_readerBloc.state.fontSize ?? FontSizes.DEFAULT_FONT_SIZE))
                    )
                  ),
                  tagMatcher("p"): CustomRender.inlineSpan(inlineSpan: (context, buildChildren) =>
                      TextSpan(
                          style: TextStyle(
                            color: context.style.color ?? Colors.black,
                            fontSize: context.style.fontSize != null ?
                                GetFontSize(context.style.fontSize?.size ?? FontSizes.DEFAULT_FONT_SIZE) :
                                GetFontSize(_readerBloc.state.fontSize ?? FontSizes.DEFAULT_FONT_SIZE)
                          ),
                      )
                  )
                  */
                   /* style: (context.tree.element!.attributes['horizontal'] != null)
                        ? FlutterLogoStyle.horizontal
                        : FlutterLogoStyle.markOnly,
                    textColor: context.style.color!,
                    size: context.style.fontSize!.size! * 5,*//*
                  )),

                  birdMatcher(): CustomRender.inlineSpan(inlineSpan: (context, buildChildren) => TextSpan(text: "🐦")),
                  modifyFontSize(): CustomRender.inlineSpan(inlineSpan: (context, buildChildren)
                    {
                      return TextSpan(text: "🐦");
                    }),
                  flutterMatcher(): CustomRender.widget(widget: (context, buildChildren) => FlutterLogo(
                    style: (context.tree.element!.attributes['horizontal'] != null)
                        ? FlutterLogoStyle.horizontal
                        : FlutterLogoStyle.markOnly,
                    textColor: context.style.color!,
                    size: context.style.fontSize!.size! * 5,
                  )),*/
                },
              ),
            ],
          )
      ),
    );
  }
}


