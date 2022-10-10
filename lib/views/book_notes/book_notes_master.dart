// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/book_note_repository.dart';
import 'package:mobi_reads/views/book_notes/book_notes.dart';

class BookNotesMasterWidget extends StatefulWidget {
  const BookNotesMasterWidget() : super();

  @override
  _BookNotesMasterWidgetState createState() => _BookNotesMasterWidgetState();
}

class _BookNotesMasterWidgetState extends State<BookNotesMasterWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Book book = DefaultEntities.EmptyBook;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(book.Id == ''){
      book = ModalRoute.of(context)!.settings.arguments as Book;
    }

    return BlocProvider(
        create: (context) => BookNotesBloc(RepositoryProvider.of<BookNoteRepository>(context), book!.Id),
        child:  BlocBuilder<BookNotesBloc, BookNotesState>(builder: (context, state) {
          return ScaffoldUI(context);
        })
    );
  }

  Widget ScaffoldUI(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          body: BookNotesWidget(book),
      )
    );
  }
}
