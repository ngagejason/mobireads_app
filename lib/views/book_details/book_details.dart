// ignore_for_file: non_constant_identifier_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_event.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_state.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class BookDetailsWidget extends StatefulWidget {
  const BookDetailsWidget(this.book) : super();

  final Book book;

  @override
  _BookDetailsWidgetState createState() => _BookDetailsWidgetState();
}

class _BookDetailsWidgetState extends State<BookDetailsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> bookImages = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    context.read<BookDetailsBloc>().add(InitializeBookDetails());
    bookImages = getBookImages();
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<BookDetailsBloc, BookDetailsState>(
      listener: (context, state) {
        if (state.Status == BookDetailsStatus.BookDetailsLoaded) {
          context.read<BookDetailsBloc>().add(Loaded());
        }
      },
      child: BlocBuilder<BookDetailsBloc, BookDetailsState>(builder: (context, state) {
        return BookDetailsUI(context);
      })
    );
  }

  Widget BookDetailsUI(BuildContext context) {

    BookDetailsState state = context.read<BookDetailsBloc>().state;

    if(state.Status != BookDetailsStatus.Loaded){
      return StandardLoadingWidget();
    }

    return CustomScrollView(
      slivers: <Widget>[
        //2
        SliverAppBar(
          expandedHeight: 30.0,
          floating: false,
          pinned: true,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(),
        ),
        //3
        SliverList(
          delegate: SliverChildListDelegate([
            getCarousel(context),
            getAuthor(context)
          ]),
        ),
      ],
    );
  }

  Widget getCarousel(BuildContext context){
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: CarouselSlider(
          options: CarouselOptions(height: 380.0),
          items: bookImages.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return getCover(i);
              },
            );
          }).toList(),
        )
    );
  }

  Widget getAuthor(BuildContext buildContext){
    TextStyle style = TextStyle(
      color: FlutterFlowTheme.of(context).secondaryColor,
      fontSize: 30,
    );

    return Padding(
        padding: EdgeInsets.fromLTRB(5, 25, 5, 0),
        child: Wrap(
          children:[
            FadeIn(
              child: Container(
                width: double.infinity,
                child: Text(
                  widget.book.AuthorName(),
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ),
              // Optional paramaters
              duration: Duration(milliseconds: 2000),
              curve: Curves.easeIn,
            )
          ]
        )
    );
  }

  Widget getCover(String url){
    return Container(
        width: 250,
        height: 375,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: Image.network(url).image,
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

  List<String> getBookImages(){
    List<String> bookImages = new List.empty(growable: true);
    bookImages.add(widget.book.FrontCoverImageUrl);
    if(widget.book.BackCoverImageUrl != null && widget.book.BackCoverImageUrl!.isNotEmpty){
      bookImages.add(widget.book.BackCoverImageUrl ?? '');
    }

    if(widget.book.AdditionalImages != null && widget.book.AdditionalImages!.length > 0){
      for(String s in widget.book.AdditionalImages!){
        bookImages.add(s);
      }
    }

    return bookImages;
  }
}
