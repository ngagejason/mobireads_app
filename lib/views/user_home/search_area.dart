import 'package:flutter/material.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_icon_button.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class SearchArea extends StatelessWidget {
  SearchArea(): super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryColor,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
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
              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
    );
  }
}
