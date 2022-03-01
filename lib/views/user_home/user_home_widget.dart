import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_block.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_event.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/peek_repository.dart';
import 'package:mobi_reads/repositories/preferences_repository.dart';
import 'package:mobi_reads/views/loading_page.dart';
import 'package:mobi_reads/views/user_home/search_area.dart';
import 'package:mobi_reads/views/widgets/peek_factory.dart';
import 'package:mobi_reads/views/widgets/preference_chip_list.dart';

class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key}) : super(key: key);

  @override
  _UserHomeWidgetState createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  String? choiceChipsValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  HashMap<int, PeekFactory> peeks = HashMap();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //return userHomeUI(context);
    return BlocProvider(
        create: (context) => PreferencesBloc(RepositoryProvider.of<PreferencesRepository>(context))..add(Initialized()),
        child: BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {
          if(state.Status == PreferencesStatus.Loading){
            return LoadingPage();
          }

          return userHomeUIListener(context);
        })
    );
  }

  Widget userHomeUIListener(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state.Status == AppStatus.LoggedOut) {
            context.read<AppBloc>().add(AppInitializingEvent());
            Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
          }
        },
        child: userHomeUI(context)
    );
  }

  Widget userHomeUI(BuildContext context) {
    List<PreferenceChip> preferences = context.read<PreferencesBloc>().state.PreferenceChips.where((element) => element.Context == 'HOME').toList();
    double _appBarHeight = 40;


    return SafeArea(
      child: BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {
        HashMap<int, PeekFactory> toSet = HashMap();
        for(int i = 0;  i < state.PreferenceChips.length; i++){
          if(state.PreferenceChips[i].IsSelected){
            if(peeks.containsKey(state.PreferenceChips[i].Code)){
              toSet[state.PreferenceChips[i].Code] = peeks[state.PreferenceChips[i].Code] as PeekFactory;
            }
            else{
              toSet[state.PreferenceChips[i].Code] = PeekFactory(Key(state.PreferenceChips[i].Label), state.PreferenceChips[i].Code, state.PreferenceChips[i].Label);
            }
          }
        }

        peeks = toSet;

        return Scaffold(
            key: scaffoldKey,
            drawer: NavDrawer(context),
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            body: CustomScrollView(
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
                        onPressed: () => { scaffoldKey.currentState!.openDrawer() })
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
                    child: ExpansionTile(
                        collapsedIconColor: FlutterFlowTheme.of(context).secondaryColor,
                        iconColor: FlutterFlowTheme.of(context).secondaryColor,
                        textColor: FlutterFlowTheme.of(context).secondaryColor,
                        collapsedTextColor: FlutterFlowTheme.of(context).secondaryColor,
                        title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ChoiceChip(
                                  label: Padding(
                                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                      child: Text(
                                        'My Preferences',
                                        style: const TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      )
                                  ),
                                  selected: true,
                                  onSelected: (bool selected) {},
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
                              )
                            ]
                        ),
                        children: <Widget>[
                          PreferenceChipList(
                            onChanged: (chipData) {
                              print('made it');
                              context.read<PreferencesBloc>().add(PreferenceToggled(chipData));

                            },
                            options: preferences,
                          ),
                        ]
                    ),
                  ),
                  for(var p in peeks.entries)
                    BlocProvider(
                        create: (context) => PeekBloc(RepositoryProvider.of<PeekRepository>(context)),
                        child: p.value as PeekFactory
                    ),
                    //p.value as PeekFactory
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
            )
        );
      })
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
}

