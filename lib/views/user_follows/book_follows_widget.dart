
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';

class BookFollowsWidget extends StatefulWidget {
  const BookFollowsWidget({Key? key}) : super(key: key);

  @override
  _BookFollowsWidgetState createState() => _BookFollowsWidgetState();
}

class _BookFollowsWidgetState
    extends State<BookFollowsWidget>
    with AutomaticKeepAliveClientMixin<BookFollowsWidget>, Peekable {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
      return bookFollowsUI(context);
    });
  }

  Widget bookFollowsUI(BuildContext context){

    BookFollowsState state = context.read<BookFollowsBloc>().state;
    if(state.Status != BookFollowsStatus.Loaded){
      return StandardLoadingWidget();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          getFilter(context),
          Wrap(
            spacing: 30,
              children: [
                for(var p in state.Books)
                  BookUI(context, p)
              ]
          ),
        ],
      )

    );
  }

  Widget BookUI(BuildContext context, Book book){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      child: GestureDetector(
        onLongPress: () => openDialog(context, book, context.read<BookFollowsBloc>()),
        onTap: () => {
          Navigator.pushNamed(context, "/bookDetails", arguments: book)
        },
        child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Image.network(
              book.FrontCoverImageUrl.guarantee(),
              width: 125,
              height: 188,
              fit: BoxFit.cover,
            )
        ),
      ),
    );
  }

  Widget getFilter(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
              child: Container(
                width:
                MediaQuery.of(context).size.width *
                    0.96,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0x9AFFFFFF),
                  borderRadius:
                  BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(16, 0, 0, 0),
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText:
                            'Search for Reads...',
                            enabledBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius
                                  .only(
                                topLeft:
                                Radius.circular(
                                    4.0),
                                topRight:
                                Radius.circular(
                                    4.0),
                              ),
                            ),
                            focusedBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius
                                  .only(
                                topLeft:
                                Radius.circular(
                                    4.0),
                                topRight:
                                Radius.circular(
                                    4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF1A1F24),
                            fontSize: 14,
                            fontWeight:
                            FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      color: Color(0xFF1E2429),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        buttonSize: 46,
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          print(
                              'IconButton pressed ...');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
