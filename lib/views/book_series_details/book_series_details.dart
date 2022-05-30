// ignore_for_file: non_constant_identifier_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_bloc.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_event.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class BookSeriesDetailsWidget extends StatefulWidget {
  const BookSeriesDetailsWidget(this.book) : super();

  final Book book;

  @override
  _BookSeriesDetailsWidgetState createState() => _BookSeriesDetailsWidgetState();
}

class _BookSeriesDetailsWidgetState extends State<BookSeriesDetailsWidget> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPos = 0;
  Book currentBook = DefaultEntities.EmptyBook;

  @override
  void initState() {
    super.initState();
    context.read<BookSeriesDetailsBloc>().add(InitializeBookSeriesDetails(widget.book));
    currentPos = widget.book.BookNumberInSeries - 1; // 0 indexed
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookSeriesDetailsBloc, BookSeriesDetailsState>(
      listener: (context, state) {
        if (state.Status == BookSeriesDetailsStatus.BookSeriesDetailsLoaded) {
          currentBook = state.Books[widget.book.BookNumberInSeries-1];
          context.read<BookSeriesDetailsBloc>().add(SeriesLoaded());
        }
      },
      child: BlocBuilder<BookSeriesDetailsBloc, BookSeriesDetailsState>(builder: (context, state) {
        return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
          return BookDetailsUI(context);
        });
      })
    );
  }

  Widget BookDetailsUI(BuildContext context) {

    BookSeriesDetailsState state = context.read<BookSeriesDetailsBloc>().state;
    if(state.Status != BookSeriesDetailsStatus.Loaded){
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
            getCarousel(context, state),
            getDots(context, state),
            getAuthor(context),
            getSeries(context, state),
            getMetadata(context),
            getAbout()
          ]),
        ),
      ],
    );
  }

  Widget getDots(BuildContext context, BookSeriesDetailsState state){
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          for(int i = 0; i < state.BookCountInSeries; i++)
            Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPos == i
                      ? FlutterFlowTheme.of(context).secondaryColor.withOpacity(.9)
                      : FlutterFlowTheme.of(context).secondaryColor.withOpacity(.4)
              ),
            )
        ]
    );
  }

  Widget getCarousel(BuildContext context, BookSeriesDetailsState state){
    return CarouselSlider(
      options: CarouselOptions(
          height: 300.0,
          enlargeCenterPage: true,
          initialPage: widget.book.BookNumberInSeries - 1,
          onPageChanged: (index, reason) {
            BookSeriesDetailsBloc bloc = context.read<BookSeriesDetailsBloc>();
            setState(() {
              currentPos = index;
              currentBook = bloc.state.Books[index];
            });
          }
      ),

      items: state.Books.map((book) {
        return Builder(
          builder: (BuildContext context) {
            return getCover(book.FrontCoverImageUrl);
          },
        );
      }).toList(),
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
                  currentBook.AuthorName(),
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

  Widget getSeries(BuildContext buildContext, BookSeriesDetailsState state){

    TextStyle style = TextStyle(
      color: FlutterFlowTheme.of(context).secondaryColor,
      fontSize: 16
    );

    return Padding(
        padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Wrap(
            children:[
              FadeIn(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text(
                        'Book #' + currentBook.BookNumberInSeries.toString() + ' of ' + currentBook.BookCountInSeries.toString() + ' in the ',
                        style: style,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        currentBook.SeriesTitle,
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          fontSize: 16,
                          decoration: TextDecoration.underline
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        currentBook.SeriesSubtitle,
                        style: TextStyle(
                            color: FlutterFlowTheme.of(context).secondaryColor,
                            fontSize: 14,
                            decoration: TextDecoration.underline
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Series',
                        style: style,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ),
                // Optional paramaters
                duration: Duration(milliseconds: 3000),
                curve: Curves.easeIn,
              )
            ]
        )
    );
  }

  Widget getMetadata(BuildContext buildContext){

    TextStyle style = TextStyle(
        color: FlutterFlowTheme.of(context).secondaryColor,
        fontSize: 14
    );

    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Column(
                children: [
                  Icon(
                    Icons.book,
                    color: FlutterFlowTheme.of(context).secondaryColor,
                    size: 18.0
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        'Word Count',
                        style: style,
                      )
                  ),
                  Text(
                    currentBook.WordCount > 0 ? currentBook.WordCount.toString() : "0",
                    style: style,
                  ),
                ],
              ),
              /*Column(
                children: [
                  Icon(
                      Icons.question_answer,
                      color: FlutterFlowTheme.of(context).secondaryColor,
                      size: 18.0
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      'Questions Answered',
                      style: style,
                    )
                  ),
                  Text(
                      //widget.book.QuestionCount.toString()
                    '24',
                    style: style,
                  )
                ]
              ),*/
              Column(
                children:[
                  Icon(
                      Icons.favorite,
                      color: FlutterFlowTheme.of(context).secondaryColor,
                      size: 18.0
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Text(
                        'Follows',
                        style: style,
                      )
                  ),
                  Text(
                    currentBook.FollowCount > 0 ? currentBook.FollowCount.toString() : "0",
                    style: style,
                  )
                ]
              )
            ]
        )
    );
  }

  Widget getAbout(){
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
      child: Text(
        currentBook.Summary ?? '',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 1.0,
            height: 1.4
        ),
      )
    );
  }

  Widget getCover(String url){
    return Container(
        width: 200,
        height: 300,
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
}
