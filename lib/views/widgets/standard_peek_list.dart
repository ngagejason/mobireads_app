import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_block.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_event.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_state.dart';
import 'package:mobi_reads/entities/peek/Peek.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/widgets/standard_peek.dart';

class StandardPeekList extends StatefulWidget {
  const StandardPeekList(this.code, this.title) : super();

  final int code;
  final String title;

  @override
  _StandardPeek createState() => _StandardPeek(code, title);
}

class _StandardPeek extends State<StandardPeekList> {

  _StandardPeek(this.code, this.title);

  final int code;
  final String title;

  @override
  void initState() {
    super.initState();
    context.read<PeekListBloc>().add(Initialize(this.code, this.title));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PeekListBloc, PeekListState>(
        listener: (context, state) {
          if(state.Status == PeekListStatus.PeeksLoaded){
            context.read<PeekListBloc>().add(Loaded());
          }
        },
        child: PeekUI(context)
    );
  }
  Widget PeekUI(BuildContext context){

    PeekListState state = context.read<PeekListBloc>().state;

    if(state.Status != PeekListStatus.Loaded){
      return Loading(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                state.Title,
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
          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                children: state.Peeks.map((e) => StandardPeek(e.BookId)).toList(growable: false)
            ),
          ),
        ),
      ],
    );
  }

  Widget Loading(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(),
/*
        CircularProgressIndicator(
          semanticsLabel: 'Loading...',
          color: FlutterFlowTheme.of(context).secondaryColor,
        )
*/
      ],
    );
  }

  Widget Book(BuildContext context, Peek peek){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: GestureDetector(
        onLongPress: () => openDialog(context, peek),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: Image.network(peek.FrontCoverImageUrl).image,
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
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  // Follow Heart
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                    child: Container(),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFF090F13),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
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
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment .start,
                      children: [
                        Text(
                          peek.Author,
                          style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFFEE8B60),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future openDialog(BuildContext context,  Peek peek){
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
            width: 250,
            height:400,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: Image.network(peek.FrontCoverImageUrl).image,
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
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
              child:  Container(
                child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1),
                    curve: Curves.easeInExpo,
                    duration: const Duration(milliseconds: 1500),
                    builder: (BuildContext context, double opacity, Widget? child) {
                      return
                        Opacity(
                            opacity: opacity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryColor,
                                borderRadius:BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child:
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () => {

                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                              child: peek.DoesFollow ?
                                                Icon(Icons.favorite, color: Colors.red, size: 24) :
                                                Icon(Icons.favorite_border, color: Colors.white, size: 24)
                                            )      ,
                                          )
                                        ],
                                      ),
                                      Container(
                                          height:300,
                                          child:Padding(
                                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                              child: SingleChildScrollView(
                                                child: Text(
                                                    peek.Summary,
                                                    style: GoogleFonts.getFont(
                                                      'Poppins',
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18,
                                                    )
                                                )
                                              )
                                          )
                                      )
                                    ],
                                  )
                            )
                        );
                    }
                )
              ),
            )
        )
      )
    );
  }
}
