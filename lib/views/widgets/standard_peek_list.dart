import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_block.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_state.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_event.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/standard_peek.dart';

class StandardPeekList extends StatefulWidget {
  const StandardPeekList(Key key, this.code, this.title, this.bottomNavbarKey) : super(key: key);

  final int code;
  final String title;
  final GlobalKey bottomNavbarKey;

  @override
  StandardPeekState createState() => StandardPeekState(code, title);
}

class StandardPeekState extends State<StandardPeekList> {

  StandardPeekState(this.code, this.title);

  final int code;
  final String title;
  late BuildContext localContext;

  @override
  void initState() {
    super.initState();
    this.localContext = context;
  }

  doRefresh(){
    localContext.read<TrendingBooksListBloc>().add(Refresh(this.code, this.title));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingBooksListBloc, TrendingBooksListState>(builder: (context, state) {
      return BlocListener<TrendingBooksListBloc, TrendingBooksListState>(
          listener: (context, state) {
            if(state.Status == TrendingBooksListStatus.PeeksLoaded){
              context.read<TrendingBooksListBloc>().add(Loaded());
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

    TrendingBooksListState state = context.read<TrendingBooksListBloc>().state;
    if(state.Status == TrendingBooksListStatus.Constructed){
      context.read<TrendingBooksListBloc>().add(Initialize(this.code, this.title));
    }

    PreferencesState preferencesState = context.read<PreferencesBloc>().state;
    Preference? chip = preferencesState.Preferences.firstWhereOrNull((element) => element.Code == this.code);
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
                this.title,
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

  Widget getBooks(BuildContext context, TrendingBooksListState state){

    if(state.Status == TrendingBooksListStatus.PeeksLoading){
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
        children: state.Books.map((e) => StandardPeek(e, widget.bottomNavbarKey)).toList(growable: false)
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
