import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_block.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_state.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_event.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/standard_peek.dart';

class StandardPeekList extends StatefulWidget {
  const StandardPeekList(this.code, this.title) : super();

  final int code;
  final String title;

  @override
  _StandardPeek createState() => _StandardPeek(code, title);
}

class _StandardPeek extends State<StandardPeekList> {

  _StandardPeek(this.code, this.title);

  final int code;
  final String title;

  @override
  void initState() {
    super.initState();
    context.read<TrendingBooksListBloc>().add(Initialize(this.code, this.title));
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
          child: PeekUI(context)
      );
    });
  }
  Widget PeekUI(BuildContext context){

    TrendingBooksListState state = context.read<TrendingBooksListBloc>().state;

    if(state.Status != TrendingBooksListStatus.Loaded){
      return Loading(context);
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
                state.Title,
                style: FlutterFlowTheme
                    .of(context)
                    .subtitle2
                    .override(
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
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                children: state.Books.map((e) => StandardPeek(e)).toList(growable: false)
            ),
          ),
        ),
      ],
    );
  }

  Widget Loading(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(),
      ],
    );
  }
}
