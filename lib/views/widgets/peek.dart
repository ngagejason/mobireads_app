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
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/extension_methods/int_extensions.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';

class Peek extends StatefulWidget {
  const Peek(this.book, this.bottomNavbarKey) : super();

  final Book book;
  final GlobalKey bottomNavbarKey;

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
        onDoubleTap: () {
          context.read<ReaderBloc>().add(InitializeReader(widget.book, true));
          var a = this.widget.bottomNavbarKey.currentWidget as BottomNavigationBar;
          a.onTap!(2);
        },
        onTap: () => {
          if(widget.book.SeriesId != null && widget.book.SeriesId!.length > 0){
            Navigator.pushNamed(context, "/bookSeriesDetails", arguments: widget.book)
          }
          else{
            Navigator.pushNamed(context, "/bookDetails", arguments: widget.book)
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getBookImage(),
            getBookInfo()
          ],
        ),
      ),
    );
  }

  Widget getBookImage(){
    if(widget.book.SeriesId != null)
      return getSeriesImage(widget.book);

    return getSingleBookImage();
  }

  Widget getSingleBookImage(){
    return Container(
      width: 125,
      height: 188,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image.network(widget.book.FrontCoverImageUrl.guarantee()).image,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x64000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius:BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
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

  Widget getSeriesImage(Book book){
    List<Widget> containers = List.empty(growable: true);
    for(var i = 0; i < book.BookNumberInSeries.guarantee()-1; i++){
      containers.add(getBookContainer(book, i));
    }
    for(var i = book.BookCountInSeries.guarantee()-1; i > book.BookNumberInSeries.guarantee() - 1; i--){
      containers.add(getBookContainer(book, i));
    }

    return Stack(
      children: [
        for(var p in containers)
          p,
        Padding(
          padding: EdgeInsets.fromLTRB(14.0*(book.BookNumberInSeries.guarantee()-1), 0, 0, 0),
          child: Container(
            width: 125,
            height: 188,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: Image.network(widget.book.FrontCoverImageUrl.guarantee()).image,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x64000000),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius:BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
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
          )
        ),
      ],
    );
  }

  Widget getBookContainer(Book book, int index){
    return Padding(
      padding:
        index > (book.BookNumberInSeries.guarantee()-1) ?
          EdgeInsets.fromLTRB(14.0*index, (10.0 * (index - (book.BookNumberInSeries.guarantee()-1)))/2, 0, 0) :
          EdgeInsets.fromLTRB(14.0*index, (10.0 * ((book.BookNumberInSeries.guarantee()-1) - index))/2, 0, 0),
      child: Container(
          width: 125,
          height: index > (book.BookNumberInSeries.guarantee()-1) ?
                188 - (10.0 * (index - (book.BookNumberInSeries.guarantee()-1))):
                188 - (10.0 * ((book.BookNumberInSeries.guarantee()-1) - index)),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: Image.network(book.SeriesFrontCoverUrls[index]).image,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x64000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius:BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          )
      )
    );
  }

  Widget getBookInfo(){

    TextStyle style = FlutterFlowTheme.of(context).bodyText1.override(
      fontFamily: 'Lexend Deca',
      color: Color(0xFFEE8B60),
      fontSize: 12,
      fontWeight: FontWeight.normal,
    );

    double offset = 0;
    if(widget.book.BookNumberInSeries != null){
      offset = widget.book.BookNumberInSeries.guarantee() > 0 ? 14 * (widget.book.BookNumberInSeries.guarantee() -1) : 0;
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(offset, 0, 0, 0),
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
      Icon(Icons.favorite_border,color: Colors.white,size: 24);
  }
}
