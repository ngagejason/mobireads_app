
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';

class BookFollowsWidget extends StatefulWidget {
  const BookFollowsWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _BookFollowsWidgetState createState() => _BookFollowsWidgetState();
}

class _BookFollowsWidgetState
    extends State<BookFollowsWidget>
    with AutomaticKeepAliveClientMixin<BookFollowsWidget>, Peekable {

  @override
  bool get wantKeepAlive => true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
      return BookFollowsUI(context);
    });
  }

  Widget BookFollowsUI(BuildContext context){

    BookFollowsState state = context.read<BookFollowsBloc>().state;
    if(state.Status != BookFollowsStatus.Loaded){
      return StandardLoadingWidget();
    }

    return ListView(
        children: [
          Container(
            height: 15,
          ),
          for(var p in state.Books)
            BookUI(context, p)
        ]
    );
  }

  Widget BookUI(BuildContext context, Book book){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: GestureDetector(
        onLongPress: () => openDialog(context, book, context.read<BookFollowsBloc>()),
        onTap: () => {Navigator.pushNamed(context, "/bookDetails", arguments: book)},
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Image.network(
                    book.FrontCoverImageUrl,
                    width: 125,
                    height: 188,
                    fit: BoxFit.cover,
                  )
              ),
              Flexible(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Padding(
                            padding: EdgeInsets.fromLTRB(5,5,5,5),
                            child: Text(book.Title, style: FlutterFlowTheme.of(context).title1, textAlign: TextAlign.center,)
                        ),
                        book.Subtitle == null ?
                          Container() :
                          Text(book.Subtitle ?? '', style: FlutterFlowTheme.of(context).title3, textAlign: TextAlign.center,)
                      ]
                  )
              ),
            ]
        ),
      ),
    );
  }
}
