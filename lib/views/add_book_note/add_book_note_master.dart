// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_bloc.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_state.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/book_note_repository.dart';
import 'package:mobi_reads/views/add_book_note/add_book_note.dart';
import 'package:mobi_reads/views/add_book_note/add_book_parms.dart';
import 'package:mobi_reads/views/book_notes/book_notes.dart';

class AddBookNoteMasterWidget extends StatefulWidget {
  const AddBookNoteMasterWidget() : super();

  @override
  _AddBookNoteMasterWidgetState createState() => _AddBookNoteMasterWidgetState();
}

class _AddBookNoteMasterWidgetState extends State<AddBookNoteMasterWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  AddBookNoteParams? addBookNoteParams;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(addBookNoteParams == null){
      addBookNoteParams = ModalRoute.of(context)!.settings.arguments as AddBookNoteParams;
    }

    return BlocProvider(
        create: (context) => AddBookNoteBloc(RepositoryProvider.of<BookNoteRepository>(context), addBookNoteParams!.bookNotesBloc),
        child:  BlocBuilder<AddBookNoteBloc, AddBookNoteState>(builder: (context, state) {
          return ScaffoldUI(context);
        })
    );
  }

  Widget ScaffoldUI(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          //key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          body: AddBookNoteWidget(addBookNoteParams!),
      )
    );
  }
}
