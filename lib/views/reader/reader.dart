import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
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
  bool needsScroll = true;

  @override initState(){
    super.initState();
    _appBloc = context.read<AppBloc>();
    _readerBloc = context.read<ReaderBloc>();
    _scrollController.addListener(_onScroll);
    context.read<ReaderBloc>().add(InitializeReader(_readerBloc.state.book ?? DefaultEntities.EmptyBook, false));

  }

  @override
  Widget build(BuildContext context) {

    if(needsScroll){
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _scrollController.animateTo(_readerBloc.state.scrollOffset, duration: Duration(milliseconds: 50), curve: Curves.ease);
        needsScroll = false;
      });
    }

    return BlocListener<ReaderBloc, ReaderState>(
        listener: (context, state) {
          if (state.status == ReaderStatus.ChaptersLoaded) {
            _readerBloc.add(Loaded());
          }
        },
        child: userHomeUI(context)
    );
  }

  Widget userHomeUI(BuildContext context) {
    double _appBarHeight = 50;

    return BlocBuilder<ReaderBloc, ReaderState>(builder: (context, state) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            toolbarHeight: _appBarHeight,
            collapsedHeight: _appBarHeight,
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            expandedHeight: 40,
            onStretchTrigger: () async => { print('stretched') },
            leading: Container(),
            pinned: false,
            stretch: true,
            actions: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: IconButton(
                      icon: const Icon(Icons.settings_outlined, color: Color(0xD8EACD29)),
                      tooltip: 'Settings',
                      onPressed: () => { widget.scaffoldKey.currentState!.openDrawer() })
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],

            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                if(index == 0){
                  return getCover();
                }
                return ChapterWidget(chapter: _readerBloc.state.allChapters[index-1]);
              },
              childCount: _readerBloc.state.allChapters.length+1,
            ),
          )
          /*SliverList(delegate: SliverChildListDelegate([
          // Search
          for(int i = 0; i < _readerBloc.state.allChapters.length; i++)
              ChapterWidget(chapter: _readerBloc.state.allChapters[i])
        ]))*/
        ],
      );
    });
  }

  Widget getCover(){
    var test = _readerBloc.state.book?.FrontCoverImageUrl ?? '';
    if(test.length > 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
            child: Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: Image.network(test).image,
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
          )
        ]
      );
    }

    return Container();
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

    _readerBloc.add(ScrollChanged(_scrollController.offset));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * .9);
  }

  Widget ChaptersUI(BuildContext context){
    if(_readerBloc.state.book == null || _readerBloc.state.book?.Id.length == 0){
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
