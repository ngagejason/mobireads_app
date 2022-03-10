import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_block.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_event.dart';
import 'package:mobi_reads/blocs/peek_list_bloc/peek_list_state.dart';
import 'package:mobi_reads/entities/DefaultEntities.dart';
import 'package:mobi_reads/entities/peek/Peek.dart';
import 'package:mobi_reads/extension_methods/first_where_or_null.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class StandardPeek extends StatefulWidget {
  const StandardPeek(this.bookId) : super();

  final String bookId;

  @override
  _StandardPeekState createState() => _StandardPeekState();
}

class _StandardPeekState extends State<StandardPeek> {

  _StandardPeekState();
  Peek peek = DefaultEntities.EmptyPeek;
  PeekListBloc? peekListBloc;

  @override
  void initState() {
    super.initState();
    peekListBloc = context.read<PeekListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeekListBloc, PeekListState>(builder: (context, state) {
        Peek? peek = state.Peeks.firstWhereOrNull((e) => e.BookId == widget.bookId);
        if(peek == null){
          return Container();
        }
        this.peek = peek;
        return Book(context);
    });
  }
  
  Widget Book(BuildContext context){
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
                mainAxisAlignment:MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Follow Heart
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                    child: Container(
                        child: peek.DoesFollow ?
                        Icon(Icons.favorite,color: Colors.red,size: 24) :
                        Icon(Icons.favorite_border,color: Colors.white,size: 24)
                    ),
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
        builder: (context) {
          bool follows = peek.DoesFollow;
          return StatefulBuilder( builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                  width: 250,
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image
                          .network(peek.FrontCoverImageUrl)
                          .image,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x64000000),
                        offset: Offset(0, 2),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 20, 8, 20),
                    child: Container(
                        child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0.0, end: 1),
                            curve: Curves.easeInExpo,
                            duration: const Duration(milliseconds: 1500),
                            builder: (BuildContext context, double opacity,
                                Widget? child) {
                              return
                                Opacity(
                                    opacity: opacity,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme
                                              .of(context)
                                              .primaryColor,
                                          borderRadius: BorderRadius.only(
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
                                                  onTap: () {
                                                    peekListBloc?.add(ToggleFollow(peek.BookId));
                                                    setState(() => { follows = !follows });
                                                  },
                                                  child: Padding(
                                                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                      child: (follows) ?
                                                        Icon(Icons.favorite,color: Colors.red,size: 24) :
                                                        Icon(Icons.favorite_border,color: Colors.white,size: 24)
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                                height: 300,
                                                child: Padding(
                                                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                    child: SingleChildScrollView(
                                                        child: Text(
                                                            peek.Summary,
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              color: Colors
                                                                  .white,
                                                              fontWeight: FontWeight
                                                                  .w500,
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
          );
          });
        }
    );
  }
}
