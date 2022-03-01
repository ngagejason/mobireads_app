import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_block.dart';
import 'package:mobi_reads/blocs/peek_bloc/peek_state.dart';
import 'package:mobi_reads/entities/peek/Peek.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class StandardPeek extends StatelessWidget {

  PeekState state;

  StandardPeek(this.state);

  @override
  Widget build(BuildContext context) {

    if(state.Status == PeekStatus.Loading){
      return Loading(context, state);
    }

    return PeekUI(context, state);
  }

  Widget Loading(BuildContext context, PeekState state){
    return CircularProgressIndicator(
      semanticsLabel: 'Loading...',
      color: FlutterFlowTheme.of(context).secondaryColor,
    );
  }

  Widget PeekUI(BuildContext context, PeekState state){

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
              children: state.Peeks.map((e) => Book(context, e)).toList(growable: false)
            ),
          ),
        ),
      ],
    );
  }

  Widget Book(BuildContext context, Peek peek){
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
      child: GestureDetector(
        onLongPress: () => openDialog(context),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 225,
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Color(0xFF1E2429),
                          elevation: 2,
                          shape:
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
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
                ],
              ),
            ),
            Container(
              width: 150,
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

  Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('test'),
        content: Text('test2')
      )
  );
}