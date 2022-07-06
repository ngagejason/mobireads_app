import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/my_books_list_bloc/my_books_list_bloc.dart';
import 'package:mobi_reads/blocs/my_books_list_bloc/my_books_list_state.dart';
import 'package:mobi_reads/blocs/my_books_list_bloc/my_books_list_event.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peek.dart';

class MyBooksList extends StatefulWidget {
  const MyBooksList(Key key, this.bottomNavbarKey) : super(key: key);

  final GlobalKey bottomNavbarKey;

  @override
  _MyBooksList createState() => _MyBooksList();
}

class _MyBooksList extends State<MyBooksList> {

  _MyBooksList();

  late BuildContext localContext;

  @override
  void initState() {
    super.initState();
    this.localContext = context;
  }

  doRefresh(){
    localContext.read<MyBooksListBloc>().add(Refresh());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBooksListBloc, MyBooksListState>(builder: (context, state) {
      return BlocListener<MyBooksListBloc, MyBooksListState>(
          listener: (context, state) {
            if(state.Status == MyBooksListStatus.MyBooksLoaded){
              context.read<MyBooksListBloc>().add(Loaded());
            }
          },
          child: PreferencesBlocWrapper(context)
      );
    });
  }

  Widget PreferencesBlocWrapper(BuildContext){
    return BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {
      return PeekUI(context);
    });
  }

  Widget PeekUI(BuildContext context){

    MyBooksListState state = context.read<MyBooksListBloc>().state;
    if(state.Status == MyBooksListStatus.Constructed){
      context.read<MyBooksListBloc>().add(Initialize());
    }

    PreferencesState preferencesState = context.read<PreferencesBloc>().state;
    Preference? chip = preferencesState.Preferences.firstWhereOrNull((element) => element.Code == (int.tryParse(dotenv.env['MY_WRITING_PREFERENCE_CODE'] ?? '1400')));
    if(chip != null && !chip.IsSelected){
      return Container();
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'My Books',
                style: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 4, 0, 15),
          child: getBooks(context, state),
        ),
      ],
    );
  }

  Widget getBooks(BuildContext context, MyBooksListState state){

    if(state.Status == MyBooksListStatus.MyBooksLoading){
      return loading(context);
    }

    if(state.Books.length == 0){
      return Row(
        mainAxisSize: MainAxisSize.max,
        children:[
          Text(
              'There are no books for the selected preferences',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14
              )
          ),
        ]
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: state.Books.map((e) => Peek(e, widget.bottomNavbarKey)).toList(growable: false)
      ),
    );
  }

  Widget loading(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children:[SizedBox(
        height: 16,
        width: 16,
        child: CircularProgressIndicator(
          semanticsLabel: 'Loading...',
          color: FlutterFlowTheme.of(context).secondaryColor,
        ),
      )]
    );
  }
}
