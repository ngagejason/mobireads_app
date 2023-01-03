// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_bloc.dart';
import 'package:mobi_reads/blocs/book_details_bloc/book_details_event.dart' as book_details_event;
import 'package:mobi_reads/blocs/book_details_bloc/book_details_state.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_event.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/classes/NumberFormatterFactory.dart';
import 'package:mobi_reads/classes/UserKvpStorage.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/extension_methods/int_extensions.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/master_scaffold/master_scaffold_widget.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class BookDetailsWidget extends StatefulWidget {
  const BookDetailsWidget(this.book) : super();

  final Book book;

  @override
  _BookDetailsWidgetState createState() => _BookDetailsWidgetState();
}

class _BookDetailsWidgetState extends State<BookDetailsWidget> {

  List<String> bookImages = List.empty(growable: true);
  late BookDetailsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BookDetailsBloc>();
    bloc.add(book_details_event.InitializeBookDetails());
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<BookDetailsBloc, BookDetailsState>(
      listener: (context, state) {
        if (state.Status == BookDetailsStatus.BookDetailsLoaded) {
          context.read<BookDetailsBloc>().add(book_details_event.Loaded());
        }
      },
      child: BookDetailsUI(context)
    );
  }

  Widget BookDetailsUI(BuildContext context) {

    if(bloc.state.Status != BookDetailsStatus.Loaded){
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
            getCover(context, widget.book.FrontCoverImageUrl.guarantee()),
            getAuthor(context),
            getSeries(context),
            getMetadata(context),
            getAbout()
          ]),
        ),
      ],
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
                        widget.book.SeriesTitle.guarantee() + ': ' + widget.book.SeriesSubtitle.guarantee(),
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
                    widget.book.WordCount > 0 ? NumberFormatterFactory.CreateNumberFormatter().format(widget.book.WordCount).toString() : "0",
                    style: style,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.pushNamed(context, "/bookNotes", arguments: widget.book)
                },
                child: Column(
                    children: [
                      Icon(
                          Icons.note,
                          color: FlutterFlowTheme.of(context).secondaryColor,
                          size: 18.0
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            'Notes',
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
                    widget.book.FollowCount.guarantee() > 0 ? widget.book.FollowCount.toString() : "0",
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
        widget.book.Summary ?? '',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 1.0,
            height: 1.4
        ),
      )
    );
  }

  Widget getCover(BuildContext buildContext, String url){
    BookFollowsBloc bloc = context.read<BookFollowsBloc>();
    bool follows = bloc.state.isBookFollowed(widget.book.Id);
    return GestureDetector(
      onDoubleTap:  () async {
        context.read<ReaderBloc>().add(InitializeReader(widget.book, true));
        // await UserKvpStorage.setCurrentBookId(widget.book.Id);
        // (MasterScaffoldWidgetState.bottomNavBarKey.currentWidget as BottomNavigationBar).onTap!(2);
        Navigator.pop(context);
      },
      child: Row(
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          bloc.add(ToggleFollow(widget.book));
                          //setState(() => { follows = !follows });
                        },
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: (follows) ?
                            Icon(Icons.favorite,color: Colors.red,size: 26) :
                            Icon(Icons.favorite_border,color: FlutterFlowTheme.of(context).secondaryColor ,size: 26)
                        ),
                      ),
                    ],
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
