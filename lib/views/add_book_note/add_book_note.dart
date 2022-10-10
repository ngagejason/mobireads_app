// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_bloc.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_event.dart';
import 'package:mobi_reads/blocs/add_book_note_bloc/add_book_note_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/add_book_note/add_book_parms.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';

class AddBookNoteWidget extends StatefulWidget {
  const AddBookNoteWidget(this.addBookNoteParams) : super();

  final AddBookNoteParams? addBookNoteParams;

  @override
  _AddBookNoteWidgetState createState() => _AddBookNoteWidgetState();
}

class _AddBookNoteWidgetState extends State<AddBookNoteWidget> {

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final localScaffoldKey = GlobalKey<ScaffoldState>();
  late AddBookNoteBloc bloc;
  String note = '';
  String title = '';
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = context.read<AddBookNoteBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddBookNoteBloc, AddBookNoteState>(
      listener: (context, state) {
        if (state.Status == AddBookNoteStatus.BookNoteAdded) {
          Navigator.pop(context);
        }
        else if(state.Status == AddBookNoteStatus.Error){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: ErrorSnackbar(header: "Error", message: state.Error)),
          );
        }
      },
      child: AddBookNoteUI(context)
    );
  }


  Widget AddBookNoteUI(BuildContext context) {

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
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  autofocus: true,
                  controller: _titleController,
                  onChanged: (text) => { title = text },
                  maxLines: null,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 60, 10, 0),
                child: Text(
                  "Note",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  autofocus: true,
                  controller: _noteController,
                  onChanged: (text) => { note = text },
                  maxLines: null,
                  style: TextStyle(
                    color: Colors.white
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.add(AddBookNote(widget.addBookNoteParams!.bookId, title, note));
        },
        backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
        child: const Icon(Icons.save),
      ),
    );
  }
}
