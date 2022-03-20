import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_block.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_state.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
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
    return BlocProvider<TrendingBooksListBloc>(
        create: (context) => TrendingBooksListBloc(
            RepositoryProvider.of<BookRepository>(context)
        ),
        child: PeekUI(context)
    );
    return PeekUI(context);
  }

  Widget PeekUI(BuildContext context){
    return BlocBuilder<TrendingBooksListBloc, TrendingBooksListState>(builder: (context, state) {
      return StandardPeekList(this.code, this.title);
    });
  }
}

