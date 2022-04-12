import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_event.dart' as book_follows_events;
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_event.dart' as preferences_events;
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/loading_page.dart';
import 'package:mobi_reads/views/user_home/search_area.dart';
import 'package:mobi_reads/views/widgets/peek_list_factory.dart';
import 'package:mobi_reads/views/widgets/preference_chip_list.dart';
import 'package:mobi_reads/views/widgets/preferences_expansion_tile.dart';
import 'package:mobi_reads/views/widgets/preferences_tile.dart';


class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _UserHomeWidgetState createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  String? choiceChipsValue;
  TextEditingController? textController;
  List<PeekListFactory> peeks = List.empty(growable: true);
  bool genresOpen = false;
  bool agesOpen = false;
  bool pubTypesOpen = false;
  final GlobalKey<PreferencesExpansionTileState> genresExpansionTileKey = new GlobalKey();
  late PreferencesBloc preferencesBloc;
  late BookFollowsBloc bookFollowsBloc;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    preferencesBloc = context.read<PreferencesBloc>();
    preferencesBloc.add(preferences_events.InitializePreferences());
    bookFollowsBloc = context.read<BookFollowsBloc>();
    bookFollowsBloc.add(book_follows_events.InitializeBookFollows());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PreferencesBloc, PreferencesState>(
            listener: (context, state) {
              if (state.Status == PreferencesStatus.PreferencesLoaded) {
                for(int i = 0;  i < state.PreferenceChips.length; i++){
                  if(state.PreferenceChips[i].IsSelected){
                    peeks.add(PeekListFactory(Key(state.PreferenceChips[i].Label), state.PreferenceChips[i].Code, state.PreferenceChips[i].Label));
                  }
                }
                context.read<PreferencesBloc>().add(preferences_events.Loaded());
              }
            }
        ),
        BlocListener<BookFollowsBloc, BookFollowsState>(
          listener: (context, state) {
            if(state.Status == BookFollowsStatus.BookFollowsLoaded){
              context.read<BookFollowsBloc>().add(book_follows_events.Loaded());
            }
          },
        ),
      ],

      child: BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {

        return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
          if(preferencesBloc.state.Status == PreferencesStatus.Loaded){
            return userHomeUI(context);
          }

          return LoadingPage();
        });
      })
    );
  }

  Widget userHomeUI(BuildContext context) {
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
          actions: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: IconButton(
                    icon: const Icon(Icons.settings_outlined, color: Color(0xD8EACD29)),
                    tooltip: 'Settings',
                    onPressed: () => { widget.scaffoldKey.currentState!.openDrawer() })
            )
          ],
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: SearchArea(),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: getPrefsRow(), /*PreferencesExpansionTile(
                key: genresExpansionTileKey,
                collapsedIconColor: FlutterFlowTheme.of(context).primaryColor,
                iconColor: FlutterFlowTheme.of(context).primaryColor,
                textColor: FlutterFlowTheme.of(context).primaryColor,
                collapsedTextColor: FlutterFlowTheme.of(context).primaryColor,
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ChoiceChip(
                          label: Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text(
                                'My Genres',
                                style: const TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              )
                          ),
                          selected: true,
                          onSelected: (bool selected) {
                            genresExpansionTileKey.currentState!.toggleExpanded();
                          },
                          selectedColor: FlutterFlowTheme.of(context).secondaryColor,
                          avatar:
                          Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Icon(
                                Icons.room_preferences_outlined,
                                color: Colors.white,
                                size: 16,
                              )
                          ),
                          backgroundColor: const Color(0xFFEACD29),
                          labelPadding: EdgeInsets.zero,
                          elevation: 4
                      ),
                    ]
                ),
                children: <Widget>[
                  PreferenceChipList(
                    onChanged: (chipData) {
                      if(chipData.IsSelected){
                        peeks.removeWhere((element) => element.code == chipData.Code);
                      }
                      else{
                        peeks.add(PeekListFactory(Key(chipData.Label), chipData.Code, chipData.Label));
                        peeks.sort((a,b) => a.code.compareTo(b.code));
                      }

                      context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData));

                    },
                    options: preferences,
                  ),
                ]
            ),*/
          ),
          for(var p in peeks)
            p,
          /*// Popular Reads
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Popular Reads',
                              style: FlutterFlowTheme
                                  .of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 250,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: Image
                                          .asset(
                                        'assets/images/HowToTrainYourDragon.PNG',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0x9839D2C0),
                                              elevation: 0,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    6, 2, 6, 2),
                                                child: Text(
                                                  '1,365 Saved',
                                                  style: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyText2
                                                      .override(
                                                    fontFamily:
                                                    'Lexend Deca',
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEE8B60),
                                                borderRadius:
                                                BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(8),
                                                  bottomRight:
                                                  Radius.circular(0),
                                                  topLeft:
                                                  Radius.circular(0),
                                                  topRight:
                                                  Radius.circular(0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        4, 4, 4),
                                                    child: Text(
                                                      '14',
                                                      textAlign: TextAlign
                                                          .center,
                                                      style:
                                                      FlutterFlowTheme
                                                          .of(context)
                                                          .title3
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Music Festi…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sam’s Burger Joint',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 250,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: Image
                                          .asset(
                                        'assets/images/imageSanAn@3x.jpg',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0x9839D2C0),
                                              elevation: 0,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    6, 2, 6, 2),
                                                child: Text(
                                                  '1,365 Saved',
                                                  style: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyText2
                                                      .override(
                                                    fontFamily:
                                                    'Lexend Deca',
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEE8B60),
                                                borderRadius:
                                                BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(8),
                                                  bottomRight:
                                                  Radius.circular(0),
                                                  topLeft:
                                                  Radius.circular(0),
                                                  topRight:
                                                  Radius.circular(0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        4, 4, 4),
                                                    child: Text(
                                                      '14',
                                                      textAlign: TextAlign
                                                          .center,
                                                      style:
                                                      FlutterFlowTheme
                                                          .of(context)
                                                          .title3
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Music Festi…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sam’s Burger Joint',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 250,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: Image
                                          .asset(
                                        'assets/images/austin-neill-hgO1wFPXl3I-unsplash.jpg',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0x9839D2C0),
                                              elevation: 0,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    6, 2, 6, 2),
                                                child: Text(
                                                  '1,365 ATTENDING',
                                                  style: FlutterFlowTheme
                                                      .of(context)
                                                      .bodyText2
                                                      .override(
                                                    fontFamily:
                                                    'Lexend Deca',
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFEE8B60),
                                                borderRadius:
                                                BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(8),
                                                  bottomRight:
                                                  Radius.circular(0),
                                                  topLeft:
                                                  Radius.circular(0),
                                                  topRight:
                                                  Radius.circular(0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(4,
                                                        4, 4, 4),
                                                    child: Text(
                                                      '14',
                                                      textAlign: TextAlign
                                                          .center,
                                                      style:
                                                      FlutterFlowTheme
                                                          .of(context)
                                                          .title3
                                                          .override(
                                                        fontFamily:
                                                        'Lexend Deca',
                                                        color:
                                                        Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Music Festi…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sam’s Burger Joint',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // New Reads
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'New Reads',
                              style: FlutterFlowTheme
                                  .of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 130,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image
                                          .asset(
                                        'assets/images/HowToTrainYourDragon.PNG',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'How To Train\nYour Dragon',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'YA, Fantasy',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFFEE8B60),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 130,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image
                                          .asset(
                                        'assets/images/imageSanAn@3x.jpg',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Mu…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sept 14th, 7:00pm',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFFEE8B60),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 130,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image
                                          .asset(
                                        'assets/images/actionvance-eXVd7gDPO9A-unsplash.jpg',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Mu…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sept 14th, 7:00pm',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFFEE8B60),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // New Reads
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'New Reads',
                              style: FlutterFlowTheme
                                  .of(context)
                                  .subtitle2
                                  .override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 130,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image
                                          .asset(
                                        'assets/images/HowToTrainYourDragon.PNG',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'How To Train\nYour Dragon',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'YA, Fantasy',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFFEE8B60),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 130,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image
                                          .asset(
                                        'assets/images/imageSanAn@3x.jpg',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Mu…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sept 14th, 7:00pm',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFFEE8B60),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 8, 0, 8),
                                child: Container(
                                  width: 130,
                                  height: 170,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image
                                          .asset(
                                        'assets/images/actionvance-eXVd7gDPO9A-unsplash.jpg',
                                      )
                                          .image,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                        color: Color(0x64000000),
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional
                                            .fromSTEB(8, 4, 8, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(0xFF1E2429),
                                              elevation: 2,
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    30),
                                              ),
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    8, 8, 8, 8),
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 250,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF090F13),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft:
                                            Radius.circular(8),
                                            bottomRight:
                                            Radius.circular(8),
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  8, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    'San Antonio Mu…',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Sept 14th, 7:00pm',
                                                    style:
                                                    FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily:
                                                      'Lexend Deca',
                                                      color: Color(
                                                          0xFFEE8B60),
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),*/
        ]
        ))
      ],
    );
  }

  Widget NavDrawer(BuildContext context) {
    var appBloc = context.read<AppBloc>();
    return Drawer(
        child: Container(
          color: FlutterFlowTheme
              .of(context)
              .secondaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[

              DrawerHeader(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme
                        .of(context)
                        .secondaryColor,
                  ),
                  child: getAvatar(appBloc.state.Username)
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Profile'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle_sharp),
                title: Text('User Accounts'),
                onTap: () => {Navigator.pushNamed(context, "/userAccounts")},
              ),
              ListTile(
                leading: Icon(Icons.stacked_line_chart),
                title: Text('Writers Block'),
                onTap: () =>
                {
                  Navigator.pushNamed(context, "/linkedInstitutions")
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Publishing'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.border_color),
                title: Text('Feedback'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () =>
                {
                  context.read<AppBloc>().add(UserLoggedOutEvent())
                },
              ),
            ],
          ),
        )
    );
  }

  Widget getAvatar(String username) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Text(
          username.toString(),
          style: TextStyle(
              fontSize: 30,
              color: Colors.black54
          ),
        )
    );
  }

  Widget getPrefsRow(){
    List<PreferenceChip> genrePreferences = context.read<PreferencesBloc>().state.PreferenceChips.where((element) => element.Context == 'HOME').toList();
    List<PreferenceChip> ageGroupsPreferences = context.read<PreferencesBloc>().state.PreferenceChips.where((element) => element.Context == 'AGE_GROUP').toList();
    List<PreferenceChip> pubTypesPreferences = context.read<PreferencesBloc>().state.PreferenceChips.where((element) => element.Context == 'PUB_TYPE').toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
          children: [
            Row(
                children: [
                  getPreferenceChip('Genres', (selected) { setState(() { genresOpen = !genresOpen; }); }, () { return genresOpen; }),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: getPreferenceChip('Ages', (selected) { setState(() { agesOpen = !agesOpen; }); }, () { return agesOpen; })
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,0,0),
                    child: getPreferenceChip('Pub Types', (selected) { setState(() { pubTypesOpen = !pubTypesOpen; }); }, () { return pubTypesOpen; })
                  )
                ]
            ),
            ExpandedSection(
                expand: genresOpen,
                child: PreferenceChipList(
                  onChanged: (chipData) {
                    if(chipData.IsSelected){
                      peeks.removeWhere((element) => element.code == chipData.Code);
                    }
                    else{
                      peeks.add(PeekListFactory(Key(chipData.Label), chipData.Code, chipData.Label));
                      peeks.sort((a,b) => a.code.compareTo(b.code));
                    }

                    context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData));

                  },
                  options: genrePreferences,
                )
            ),
            ExpandedSection(
                expand: agesOpen,
                child: PreferenceChipList(
                  onChanged: (chipData) {
                    if(chipData.IsSelected){
                      peeks.removeWhere((element) => element.code == chipData.Code);
                    }
                    else{
                      peeks.add(PeekListFactory(Key(chipData.Label), chipData.Code, chipData.Label));
                      peeks.sort((a,b) => a.code.compareTo(b.code));
                    }

                    context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData));

                  },
                  options: ageGroupsPreferences,
                )
            ),
            ExpandedSection(
                expand: pubTypesOpen,
                child: PreferenceChipList(
                  onChanged: (chipData) {
                    if(chipData.IsSelected){
                      peeks.removeWhere((element) => element.code == chipData.Code);
                    }
                    else{
                      peeks.add(PeekListFactory(Key(chipData.Label), chipData.Code, chipData.Label));
                      peeks.sort((a,b) => a.code.compareTo(b.code));
                    }

                    context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData));

                  },
                  options: pubTypesPreferences,
                )
            )
          ]
      )
    );
  }

  Widget getPreferenceChip(String label, void Function(bool selected) onSelected, bool Function() isSelected){

    PreferenceChipStyle selectedChipStyle = const PreferenceChipStyle(
      backgroundColor: const Color(0xFFEACD29),
      textStyle: const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
      elevation: 4,
    );
    PreferenceChipStyle unselectedChipStyle = const PreferenceChipStyle(
      backgroundColor: Colors.black,
      textStyle: const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
      elevation: 4,
    );

    return ChoiceChip(
        label: Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              label,
              style: const TextStyle(
                  fontFamily: 'Lexend Deca',
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            )
        ),
        selected: isSelected(),
        labelPadding: isSelected() ? selectedChipStyle.labelPadding : unselectedChipStyle.labelPadding,
        onSelected: (bool selected) {
          onSelected(selected);
        },
        // selectedColor:  FlutterFlowTheme.of(context).secondaryColor,
        selectedColor: isSelected() ? selectedChipStyle.backgroundColor : null,
        backgroundColor: isSelected() ? null : unselectedChipStyle.backgroundColor,
        elevation: isSelected() ? selectedChipStyle.elevation : unselectedChipStyle.elevation,
    );
  }
}
