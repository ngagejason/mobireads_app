// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/views/book_details/book_details.dart';

class BookDetailsMasterWidget extends StatefulWidget {
  const BookDetailsMasterWidget() : super();

  @override
  _BookDetailsMasterWidgetState createState() => _BookDetailsMasterWidgetState();
}

class _BookDetailsMasterWidgetState extends State<BookDetailsMasterWidget> {

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
        create: (context) => BookDetailsBloc(RepositoryProvider.of<BookRepository>(context)),
        child:  BlocBuilder<BookDetailsBloc, BookDetailsState>(builder: (context, state) {
          return ScaffoldUI(context);
        })
    );
  }

  Widget ScaffoldUI(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          body: BookDetailsWidget(this.book),
      )
    );
  }
}
