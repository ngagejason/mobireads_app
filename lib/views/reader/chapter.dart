import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.chapter == null){
      return StandardLoadingWidget();
    }


    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
        color: Colors.white,
        child: Html(
            data: widget.chapter?.Writing ?? ''
        ),
      ),
    );

    /*return Text(
      widget.chapter?.Title ?? ''
    );*/
  }

  @override
  void dispose() {
    super.dispose();
  }
}


