// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/constants.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/peekable.dart';

class StandardBook extends StatefulWidget {
  const StandardBook(this.book) : super();

  final Book book;

  @override
  _StandardBookState createState() => _StandardBookState();
}

class _StandardBookState extends State<StandardBook> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
      return BookUI(context);
    });
  }

  Widget BookUI(BuildContext context){
    if(widget.book.FrontCoverImageUrl.length == 0){

    }

    return UrlCover(context);
  }

  Widget UrlCover(BuildContext context){
    return Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: Image.network(widget.book.FrontCoverImageUrl).image,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x64000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius:BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        )
    );
  }

}
