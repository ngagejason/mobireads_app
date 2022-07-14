import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_state.dart';
import 'package:mobi_reads/classes/UserKvpStorage.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/reader/chapter.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

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
  bool loading = false, allLoaded = false;
  bool needsScroll = true;
  late double scrollOffset = 0;
  late int selectedChapter;
  late AutoScrollController controller;

  @override initState(){
    super.initState();
    _readerBloc = context.read<ReaderBloc>();
    _scrollController.addListener(_onScroll);

    selectedChapter = 0;
    scrollOffset = 0;

    // This attempts to load the previous book if the reader has re-opened the app.
    if(_readerBloc.state.book == null){
      context.read<ReaderBloc>().add(InitializeReaderByBookId());
    }
    else {
      context.read<ReaderBloc>().add(InitializeReader(_readerBloc.state.book ?? DefaultEntities.EmptyBook, false));
    }

    // Assign the setScrollOffset callback function
    _readerBloc.setScrollOffset = this.setScrollOffset;

    // Use the awesome life saving AutoScrollController
    controller = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical,
    );

    // Set the AutoScrollController parentController for event chaining
    controller.parentController = _scrollController;
  }

  void setScrollOffset(double scrollOffset){
    this.scrollOffset = scrollOffset;
    Timer(const Duration(milliseconds: 500), () async {
      _scrollController.animateTo(this.scrollOffset, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onScaleUpdate: (details) {
          print('onScaleUpdate ' + details.scale.toString() + ", " + _readerBloc.currentFontSize.toString() + ", " + (details.scale * _readerBloc.currentFontSize).toString());
          if(details.scale > 1){
            _readerBloc.add(FontSizeChanged(1.05 * _readerBloc.currentFontSize));
          }
          else{
            _readerBloc.add(FontSizeChanged(.95 * _readerBloc.currentFontSize));
          }
        },
        child: BlocListener<ReaderBloc, ReaderState>(
            listener: (context, state) {
              if (state.status == ReaderStatus.ChaptersLoaded) {
                _readerBloc.add(Loaded());
              }
              else if(state.status == ReaderStatus.Error){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: ErrorSnackbar(message: state.errorMessage)),
                );
              }
            },
            child: userHomeUI(context)
        )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget userHomeUI(BuildContext context) {
    double _appBarHeight = 50;

    return BlocBuilder<ReaderBloc, ReaderState>(builder: (context, state) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: controller, // _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            toolbarHeight: _appBarHeight,
            collapsedHeight: _appBarHeight,
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            expandedHeight: 40,
            onStretchTrigger: () async => { print('stretched') },
            pinned: false,
            stretch: true,
            leading: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: IconButton(
                    icon: const Icon(Icons.menu, color: Color(0xD8EACD29)),
                    tooltip: 'Menu',
                    onPressed: () {
                      setState(() => selectedChapter = 0);
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              Theme(
                                data: ThemeData.dark(),
                                child: CupertinoActionSheet(
                                  actions: [
                                    buildPicker(),
                                    CupertinoActionSheetAction(
                                      child: const Text('Go'),
                                      onPressed: () {
                                        if(selectedChapter == 1){
                                          controller.scrollToIndex(0, preferPosition: AutoScrollPosition.begin);
                                        }
                                        else{
                                          controller.scrollToIndex(selectedChapter+1, preferPosition: AutoScrollPosition.begin);
                                        }
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              )
                      );
                    }
                )
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                  child: IconButton(
                      icon: const Icon(Icons.settings_outlined, color: Color(0xD8EACD29)),
                      tooltip: 'Settings',
                      onPressed: () => { widget.scaffoldKey.currentState!.openDrawer() })
              ),
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
                  return AutoScrollTag(
                      key: ValueKey(index),
                      controller: controller,
                      index: index,
                      child: getCover()
                  );
                }

                return AutoScrollTag(
                    key: ValueKey(index),
                    controller: controller,
                    index: index,
                    child: ChapterWidget(chapter: _readerBloc.state.allChapters[index-1])
                );
              },
              childCount: _readerBloc.state.allChapters.length+1,
            ),
          )
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
    return currentScroll >= (maxScroll);
  }

  Widget buildPicker () => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getPicker()
      ],
    )
  );

  Widget getPicker(){
    return SizedBox(
        height:250,
        child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
              setState(() => selectedChapter = value);
            },
            itemExtent: 48,
            children: _readerBloc.state.allChapters.map((element) =>
                Text(
                  element.Title.guarantee(),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).secondaryColor,
                    fontSize: 24,
                  ),
                ),
            ).toList()
        )
    );
  }

}
