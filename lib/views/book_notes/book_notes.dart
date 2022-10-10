// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_bloc.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_event.dart';
import 'package:mobi_reads/blocs/book_notes_bloc/book_notes_state.dart';
import 'package:mobi_reads/entities/book_notes/BookNote.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/add_book_note/add_book_parms.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';

class BookNotesWidget extends StatefulWidget {
  const BookNotesWidget(this.book) : super();

  final Book book;

  @override
  _BookNotesWidgetState createState() => _BookNotesWidgetState();
}

class _BookNotesWidgetState extends State<BookNotesWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> bookNotes = List.empty(growable: true);
  late BookNotesBloc bloc;
  final localScaffoldKey = GlobalKey<ScaffoldState>();
  String selectedId = '';

  @override
  void initState() {
    super.initState();
    bloc = context.read<BookNotesBloc>();
    bloc.add(InitializeBookNotes());
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<BookNotesBloc, BookNotesState>(
      listener: (context, state) {
        if (state.Status == BookNotesStatus.BookNotesLoaded) {
          context.read<BookNotesBloc>().add(Loaded());
        }
      },
      child: BookNotesUI(context)
    );
  }

  Widget BookNotesUI(BuildContext context) {
    if(bloc.state.Status != BookNotesStatus.Loaded){
      return StandardLoadingWidget();
    }

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      key: localScaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 30.0,
              floating: false,
              pinned: true,
              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar()
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if(bloc.state.BookNotes.length == 0)
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 10),
                  child: Text("No notes have been added for this book.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    )
                  )
              ),
              for(var p in bloc.state.BookNotes)
                GetNoteView(p)
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addBookNote", arguments: AddBookNoteParams(bloc, widget.book.Id));
        },
        backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }



  Widget GetNoteView(BookNote note){
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: FlutterFlowTheme.of(context).secondaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding:EdgeInsets.fromLTRB(0, 5, 0, 15),
                          child: Text(note.Title ?? 'Note', style: TextStyle(color: Colors.white, fontSize: 14))
                      ),
                      GestureDetector(
                        onTap: () {
                          selectedId = note.Id;
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Delete'),
                                content: Text('Really delete this note?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      bloc.add(new DeleteNote(selectedId, widget.book.Id));
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                          );
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 15),
                            child: Icon(
                                Icons.remove,
                                color: Colors.red,
                                size: 24.0
                            )
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 2, thickness: 1, endIndent: 20, color: FlutterFlowTheme.of(context).secondaryColor),
                  Padding(
                      padding:EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(note.Note ?? '', style: TextStyle(color: Colors.white, fontSize: 14))
                  ),
                ],
              )
          )
      )
    );
  }
}
