// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';

class StandardPeek extends StatefulWidget {
  const StandardPeek(this.book) : super();

  final Book book;

  @override
  _StandardPeekState createState() => _StandardPeekState();
}

class _StandardPeekState extends State<StandardPeek> with Peekable {

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
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: GestureDetector(
        onLongPress: () => openDialog(context, widget.book, context.read<BookFollowsBloc>()),
        onTap: () => {Navigator.pushNamed(context, "/bookDetails", arguments: widget.book)},
        child: Column(
          children: [
            Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: Image.network(widget.book.FrontCoverImageUrl).image,
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
            ),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFF090F13),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.book.AuthorName(),
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFFEE8B60),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  )
              ),
            )
          ],
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
