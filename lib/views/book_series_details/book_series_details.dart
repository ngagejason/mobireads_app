// ignore_for_file: non_constant_identifier_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_bloc.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_event.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_state.dart';
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
  List<String> bookImages = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    context.read<BookSeriesDetailsBloc>().add(InitializeBookSeriesDetails());
    bookImages = getBookImages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookSeriesDetailsBloc, BookSeriesDetailsState>(
      listener: (context, state) {
        if (state.Status == BookSeriesDetailsStatus.BookSeriesDetailsLoaded) {
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
            getCover(widget.book.FrontCoverImageUrl),
            getAuthor(context),
            getSeries(context),
            getMetadata(context),
            getAbout()
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

  Widget getSeries(BuildContext buildContext){
    if(widget.book.SeriesId == null){
      return Container();
    }

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
                        '# ' + widget.book.BookNumberInSeries.toString() + ' of ' + widget.book.BookCountInSeries.toString() + ' in the ',
                        style: style,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        widget.book.SeriesTitle + ': ' + widget.book.SeriesSubTitle,
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          fontSize: 16,
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
                    widget.book.WordCount != null && widget.book.WordCount > 0 ? widget.book.WordCount.toString() : "0",
                    style: style,
                  ),
                ],
              ),
              Column(
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
              ),
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
                    widget.book.FollowCount != null && widget.book.FollowCount > 0 ? widget.book.FollowCount.toString() : "0",
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
        widget.book.Summary,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
        )
      ],
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
