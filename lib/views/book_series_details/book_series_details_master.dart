// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_bloc.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/views/book_series_details/book_series_details.dart';

class BookSeriesDetailsMasterWidget extends StatefulWidget {
  const BookSeriesDetailsMasterWidget() : super();

  @override
  _BookSeriesDetailsMasterWidgetState createState() => _BookSeriesDetailsMasterWidgetState();
}

class _BookSeriesDetailsMasterWidgetState extends State<BookSeriesDetailsMasterWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Book book = DefaultEntities.EmptyBook;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    book = ModalRoute.of(context)!.settings.arguments as Book;

    return BlocProvider(
        create: (context) => BookSeriesDetailsBloc(RepositoryProvider.of<BookRepository>(context)),
        child:  BlocBuilder<BookSeriesDetailsBloc, BookSeriesDetailsState>(builder: (context, state) {
          return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
            return ScaffoldUI(context);
          });
        })
    );
  }

  Widget ScaffoldUI(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          body: BookSeriesDetailsWidget(this.book),
      )
    );
  }
}
