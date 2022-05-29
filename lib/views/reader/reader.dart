import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/reader/chapter.dart';
import 'package:mobi_reads/views/widgets/standard_loading_widget.dart';

class ReaderPageWidget extends StatefulWidget {

  const ReaderPageWidget({Key? key, required this.scaffoldKey, required this.bottomNavbarKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey bottomNavbarKey;

  @override
  _ReaderPageWidgetState createState() => _ReaderPageWidgetState();
}

class _ReaderPageWidgetState extends State<ReaderPageWidget> {
  final _scrollController = ScrollController();
  late ReaderBloc _readerBloc;
  late AppBloc _appBloc;
  bool loading = false, allLoaded = false;

  @override initState(){
    super.initState();
    _appBloc = context.read<AppBloc>();
    _readerBloc = context.read<ReaderBloc>();
    _scrollController.addListener(_onScroll);
    context.read<ReaderBloc>().add(InitializeReader(_appBloc.state.CurrentBook, false));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if(state.CurrentBook != _readerBloc.state.bookId){
          context.read<ReaderBloc>().add(InitializeReader(_appBloc.state.CurrentBook, true));
        }
      },
      child: BlocListener<ReaderBloc, ReaderState>(
          listener: (context, state) {
            if (state.status == ReaderStatus.ChaptersLoaded) {
              _readerBloc.add(Loaded());
            }
          },
          child: ChaptersUI(context)
      )
    );
  }

  Widget userHomeUI(BuildContext context, ReaderState state) {
    double _appBarHeight = 40;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          toolbarHeight: _appBarHeight,
          collapsedHeight: _appBarHeight,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          expandedHeight: 80,
          onStretchTrigger: () async => { print('stretched') },
          leading: Container(),
          pinned: false,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Image.asset('assets/images/mobireads_logo_4.png'),
              )
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([
          // Search
          ChaptersUI(context),
        ]
        ))
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && _readerBloc.state.status != ReaderStatus.ChaptersLoading){
      _readerBloc.add(LoadChapters());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * .9);
  }

  Widget ChaptersUI(BuildContext context){
    if(_appBloc.state.CurrentBook.length == 0){
      return Text(
        'No book loaded'
      );
    }

    return Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if(_readerBloc.state.status == ReaderStatus.ChaptersLoading){
                return StandardLoadingWidget();
              }
              else {
                return ChapterWidget(chapter: _readerBloc.state.allChapters[index]);
              }
            },
            itemCount: _readerBloc.state.allChapters.length,
            controller: _scrollController,
          ),
    );
  }

 /* void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: DefaultError(message: message)));
  }*/

}
