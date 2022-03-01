import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_block.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_event.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/peek_repository.dart';
import 'package:mobi_reads/views/widgets/standard_peek.dart';
import 'package:mobi_reads/views/widgets/wide_peek.dart';

class PeekFactory extends StatefulWidget {
  const PeekFactory(Key? key, this.code, this.title) : super(key: key);

  final int code;
  final String title;

  @override
  _PeekFactory createState() => _PeekFactory(code, title);
}

class _PeekFactory extends State<PeekFactory> {

  _PeekFactory(this.code, this.title);

  final int code;
  final String title;

  @override
  void initState() {
    super.initState();
    if(context.read<PeekBloc>().state.Status == PeekStatus.Loading)
      context.read<PeekBloc>().add(Initialized(this.code, this.title));
  }

  @override
  Widget build(BuildContext context) {
    return PeekUI(context);
  }

  Widget PeekUI(BuildContext context){

    return BlocBuilder<PeekBloc, PeekState>(builder: (context, state) {
      if(state.Peeks.length > 0 && state.DisplayType == 1){
        return StandardPeek(state);
      }
      else if(state.Peeks.length > 0 && state.DisplayType == 2){
        return WidePeek();
      }

      return Container(child: Text(this.title),);
    });
  }
}

