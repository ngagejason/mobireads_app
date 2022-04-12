
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';

class BookFollowsWidget2 extends StatefulWidget {
  const BookFollowsWidget2({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _BookFollowsWidgetState2 createState() => _BookFollowsWidgetState2();
}

class _BookFollowsWidgetState2
    extends State<BookFollowsWidget2>
    with AutomaticKeepAliveClientMixin<BookFollowsWidget2>, Peekable {

  @override
  bool get wantKeepAlive => true;

  String searchString = "";

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

    return userHomeUI(context, state);
  }

  Widget BookUI(BuildContext context, Book book){
    return Visibility(
      visible: book.ContainsText(searchString.toUpperCase()),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
        child: GestureDetector(
          onLongPress: () => openDialog(context, book, context.read<BookFollowsBloc>()),
          onTap: () => {
            if(book.SeriesId != null && book.SeriesId!.length > 0){
              Navigator.pushNamed(context, "/bookSeriesDetails", arguments: book)
            }
            else{
              Navigator.pushNamed(context, "/bookDetails", arguments: book)
            }
          },
          child: Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Image.network(
                book.FrontCoverImageUrl,
                width: 125,
                height: 188,
                fit: BoxFit.cover,
              )
          ),
        ),
      )
    );
  }

  Widget getSearchArea(BuildContext context) {
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
                width: MediaQuery.of(context).size.width * 0.96,
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
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: TextFormField(
                          obscureText: false,
                          onChanged: (text) {
                            setState(() => searchString = text);
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for Reads...',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight:Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder:
                            UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 1,
                              ),
                              borderRadius:
                              const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF1A1F24),
                            fontSize: 14,
                            fontWeight:FontWeight.normal,
                          ),
                        ),
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

  Widget userHomeUI(BuildContext context, BookFollowsState state) {
    double _appBarHeight = 40;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          toolbarHeight: _appBarHeight,
          collapsedHeight: _appBarHeight,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          expandedHeight: 80,
          onStretchTrigger: () async => { print('stretched') },
          leading: Container(),
          pinned: false,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Image.asset('assets/images/mobireads_logo_4.png'),
              )
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([
          // Search
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: getSearchArea(context),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(40, 20, 40, 20),
            child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  for(var p in state.Books)
                    BookUI(context, p)
                ]
            ),
          ),
        ]
        ))
      ],
    );
  }
}
