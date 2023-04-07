// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/classes/NumberFormatterFactory.dart';
import 'package:mobi_reads/classes/UserKvpStorage.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/extension_methods/int_extensions.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';

class Peek extends StatefulWidget {
  const Peek(this.book, this.openBookView) : super();

  final Book book;
  final Function() openBookView;

  @override
  _PeekState createState() => _PeekState();
}

class _PeekState extends State<Peek> with Peekable {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
        return BookUI(context);
    });
  }
  
  Widget BookUI(BuildContext context){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
      child: GestureDetector(
        onLongPress: () => openDialog(context, widget.book, context.read<BookFollowsBloc>()),
        onDoubleTap: () async {
          context.read<ReaderBloc>().add(InitializeReader(widget.book, true));
          await UserKvpStorage.setCurrentBookId(widget.book.Id);
          widget.openBookView();
        },
        onTap: () => {
          Navigator.pushNamed(context, "/bookDetails", arguments: widget.book)
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSingleBookView(),
            getBookInfo()
          ],
        ),
      ),
    );
  }

  Widget getSingleBookView(){
    double width = 125;
    double height = 199;
    BoxShadow boxShadow = BoxShadow(
      blurRadius: 3,
      color: Color(0x64000000),
      offset: Offset(0, 2),
    );

    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    );

    if(widget.book.FrontCoverImageUrl == null){
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            boxShadow
          ],
          borderRadius: borderRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 20, 8, 0),
                      child: Text(
                        widget.book.Title.guarantee(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 0),
                    child: Text(
                      widget.book.Subtitle.guarantee(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Follow Heart
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
              child: Container(
                  child: getFollowsIcon(context)
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image.network(widget.book.FrontCoverImageUrl.guarantee()).image,
        ),
        boxShadow: [
          boxShadow
        ],
        borderRadius: borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment:MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Follow Heart
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
            child: Container(
                child: getFollowsIcon(context)
            ),
          ),
        ],
      ),
    );
  }

  Widget getBookInfo(){

    TextStyle style = FlutterFlowTheme.of(context).bodyText1.override(
      fontFamily: 'Lexend Deca',
      color: Color(0xFFEE8B60),
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        alignment: Alignment.center,
        width: 125,
        decoration: BoxDecoration(
          color: Color(0xFF090F13),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Column(
            children: [
              Padding(
                  padding:EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.book.AuthorName(),
                        style: style,
                      )
                  )
              ),
              Padding(
                  padding:EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        NumberFormatterFactory.CreateNumberFormatter().format(widget.book.WordCount).toString() + ' Words',
                        style: style,
                      )
                  )
              )
            ]
        ),
      ),
    );
  }

  Widget getFollowsIcon(BuildContext context){
    bool doesFollow = context.read<BookFollowsBloc>().state.isBookFollowed(widget.book.Id);
    return doesFollow ?
      Icon(Icons.favorite,color: Colors.red,size: 24) :
      Icon(Icons.favorite_border,color: FlutterFlowTheme.of(context).secondaryColor,size: 24);
  }
}
