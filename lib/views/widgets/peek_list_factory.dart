import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_block.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_state.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/repositories/peek_repository.dart';
import 'package:mobi_reads/views/widgets/standard_peek_list.dart';

class PeekListFactory extends StatefulWidget {
  const PeekListFactory(Key? key, this.code, this.title) : super(key: key);

  final int code;
  final String title;

  @override
  _PeekListFactory createState() => _PeekListFactory(code, title);
}

class _PeekListFactory extends State<PeekListFactory> {

  _PeekListFactory(this.code, this.title);

  final int code;
  final String title;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PeekListBloc>(
        create: (context) => PeekListBloc(
            RepositoryProvider.of<PeekRepository>(context),
            RepositoryProvider.of<BookRepository>(context)
        ),
        child: PeekUI(context)
    );
    return PeekUI(context);
  }

  Widget PeekUI(BuildContext context){

    return BlocBuilder<PeekListBloc, PeekListState>(builder: (context, state) {
      return StandardPeekList(this.code, this.title);
    });
  }
}

