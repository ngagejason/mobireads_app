import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_event.dart';
import 'package:mobi_reads/entities/books/Book.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

abstract class Peekable {

  Future openDialog(BuildContext context, Book book, BookFollowsBloc bloc){
    return showDialog(
        context: context,
        builder: (context) {
          bool follows = bloc.state.isBookFollowed(book.Id);
          return StatefulBuilder( builder: (context, setState) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                content: Container(
                    width: 250,
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: Image.network(book.FrontCoverImageUrl).image,
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
                                                      bloc.add(ToggleFollow(book));
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
                                                              book.Summary,
                                                              style: GoogleFonts.getFont('Poppins', color: Colors .white, fontWeight: FontWeight.w500, fontSize: 18,)
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