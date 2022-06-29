import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/my_books_list_bloc/my_books_list_bloc.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_block.dart';
import 'package:mobi_reads/blocs/trending_books_list_bloc/trending_books_list_state.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/views/widgets/my_books_list.dart';
import 'package:mobi_reads/views/widgets/peek_list.dart';

class MyBooksListFactory extends StatefulWidget {
  const MyBooksListFactory(this.key2, this.bottomNavbarKey) : super();

  final Key key2;
  final GlobalKey bottomNavbarKey;

  @override
  _MyBooksListFactory createState() => _MyBooksListFactory(key2);
}

class _MyBooksListFactory extends State<MyBooksListFactory> {

  _MyBooksListFactory(this.key2);

  final Key key2;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyBooksListBloc>(
        create: (context) => MyBooksListBloc(
            RepositoryProvider.of<BookRepository>(context)
        ),
        child: PeekUI(context)
    );
    return PeekUI(context);
  }

  Widget PeekUI(BuildContext context){
    return BlocBuilder<TrendingBooksListBloc, TrendingBooksListState>(builder: (context, state) {
      return MyBooksList(this.key2, widget.bottomNavbarKey);
    });
  }
}

