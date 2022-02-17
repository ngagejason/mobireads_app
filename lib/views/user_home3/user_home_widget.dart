import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_choice_chips.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key}) : super(key: key);

  @override
  _UserHomeWidgetState createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  String? choiceChipsValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    //return userHomeUI(context);
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      return userHomeUIListener(context);
    });
  }

  Widget userHomeUIListener(BuildContext context){
    return BlocListener<AppBloc, AppState>(
        listener: (context, state){
          if (state.Status == AppStatus.LoggedOut) {
            context.read<AppBloc>().add(AppInitializingEvent());
            Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
          }
        },
        child: userHomeUI(context)
    );
  }

  Widget userHomeUI(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      drawer: NavDrawer(context),
      backgroundColor: FlutterFlowTheme.of(context).primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            homePeek(context),
            homeBody(context)
          ],
        ),
      ),
    );
  }

  Widget homePeek(BuildContext context){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryColor,
          ),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {scaffoldKey.currentState!.openDrawer();},
          child: Text('TextButton'),
        ),
        Container(
          width: 100,
          height: 100,
          constraints: BoxConstraints(
            maxWidth: 50,
            maxHeight: 50,
          ),
          decoration: BoxDecoration(
            color: Color(0x00EEEEEE),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: Image.asset(
                'assets/images/mobireads_logo_4.png',
              ).image,
            ),
          ),
        ),
        InkWell (
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryColor,
            ),
            child: Icon(
              Icons.settings_outlined,
              color: Color(0xD8EACD29),
              size: 24,
            ),
          ),
        )
      ],
    );
  }

  Widget homeBody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: [
                SizedBox(
                    height:50
                ),
                Padding(
                  padding:
                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          16, 10, 16, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Hey',
                                style: FlutterFlowTheme.of(context).bodyText2
                                    .override(
                                  fontFamily: 'Lexend Deca',
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(
                                    4, 0, 0, 0),
                                child: Text(
                                  '[Username]',
                                  style: FlutterFlowTheme.of(context).bodyText1
                                      .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFFEE8B60),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 4, 0, 0),
                            child: Text(
                              'Discover Reads',
                              style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0, 16, 0, 12),
                            child: Container(
                              width:
                              MediaQuery.of(context).size.width *
                                  0.96,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0x9AFFFFFF),
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional
                                          .fromSTEB(16, 0, 0, 0),
                                      child: TextFormField(
                                        controller: textController,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText:
                                          'Search for Reads...',
                                          enabledBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                              topLeft:
                                              Radius.circular(
                                                  4.0),
                                              topRight:
                                              Radius.circular(
                                                  4.0),
                                            ),
                                          ),
                                          focusedBorder:
                                          UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                              Color(0x00000000),
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius
                                                .only(
                                              topLeft:
                                              Radius.circular(
                                                  4.0),
                                              topRight:
                                              Radius.circular(
                                                  4.0),
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyText2
                                            .override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF1A1F24),
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    clipBehavior:
                                    Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFF1E2429),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(8),
                                    ),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 30,
                                      buttonSize: 46,
                                      icon: Icon(
                                        Icons.search_outlined,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        print(
                                            'IconButton pressed ...');
                                      },
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
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                  child: FlutterFlowChoiceChips(
                    initialOption: choiceChipsValue ??= 'Popular',
                    options: [
                      ChipData('Popular'),
                      ChipData('New'),
                      ChipData('For You'),
                      ChipData('Fantasy'),
                      ChipData('Yount Adult'),
                      ChipData('Satire/Humor')
                    ],
                    onChanged: (val) =>
                        setState(() => choiceChipsValue = val),
                    selectedChipStyle: ChipStyle(
                      backgroundColor: FlutterFlowTheme.of(context).secondaryColor,
                      textStyle: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      iconColor: Colors.white,
                      iconSize: 18,
                      elevation: 4,
                    ),
                    unselectedChipStyle: ChipStyle(
                      backgroundColor: Color(0xFF262D34),
                      textStyle: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      iconColor: Color(0xFF262D34),
                      iconSize: 18,
                      elevation: 0,
                    ),
                    chipSpacing: 12,
                  ),
                ),
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
                            'Popular Reads',
                            style: FlutterFlowTheme.of(context).subtitle2.override(
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
                                    image: Image.asset(
                                      'assets/images/HowToTrainYourDragon.PNG',
                                    ).image,
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
                                                style: FlutterFlowTheme.of(context)
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
                                                    FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                    image: Image.asset(
                                      'assets/images/imageSanAn@3x.jpg',
                                    ).image,
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
                                                style: FlutterFlowTheme.of(context)
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
                                                    FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                    image: Image.asset(
                                      'assets/images/austin-neill-hgO1wFPXl3I-unsplash.jpg',
                                    ).image,
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
                                                style: FlutterFlowTheme.of(context)
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
                                                    FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                            style: FlutterFlowTheme.of(context).subtitle2.override(
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
                                    image: Image.asset(
                                      'assets/images/HowToTrainYourDragon.PNG',
                                    ).image,
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                    image: Image.asset(
                                      'assets/images/imageSanAn@3x.jpg',
                                    ).image,
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                    image: Image.asset(
                                      'assets/images/actionvance-eXVd7gDPO9A-unsplash.jpg',
                                    ).image,
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                            style: FlutterFlowTheme.of(context).subtitle2.override(
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
                                    image: Image.asset(
                                      'assets/images/HowToTrainYourDragon.PNG',
                                    ).image,
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                    image: Image.asset(
                                      'assets/images/imageSanAn@3x.jpg',
                                    ).image,
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
                                    image: Image.asset(
                                      'assets/images/actionvance-eXVd7gDPO9A-unsplash.jpg',
                                    ).image,
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
                                                  FlutterFlowTheme.of(context)
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
                                                  FlutterFlowTheme.of(context)
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget NavDrawer(BuildContext context) {
    var appBloc = context.read<AppBloc>();
    return Drawer(
        child: Container(
          color: FlutterFlowTheme.of(context).tertiaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              /*
              DrawerHeader(
                child: getAvatar(appBloc.state.email, appBloc.state.imageUrl),
                decoration: BoxDecoration(
                  color: AppColors.TradepoolGreen,
                ),
              ),
               */

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
                onTap: () => {Navigator.pushNamed(context, "/linkedInstitutions")},
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
              BlocBuilder<AppBloc, AppState>(builder: (context, state) {
                return ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () => {
                    context.read<AppBloc>().add(UserLoggedOutEvent())
                  },
                );
              }),
            ],
          ),
        )
    );
  }
}

