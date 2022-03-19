
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

import '../../blocs/book_follows_bloc/book_follows_event.dart';

class BookFollowsWidget extends StatefulWidget {
  const BookFollowsWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _BookFollowsWidgetState createState() => _BookFollowsWidgetState();
}

class _BookFollowsWidgetState
    extends State<BookFollowsWidget>
    with AutomaticKeepAliveClientMixin<BookFollowsWidget> {

  @override
  bool get wantKeepAlive => true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BookFollowsUI(context);
  }

  Widget BookFollowsUI(BuildContext context){

    BookFollowsState state = context.read<BookFollowsBloc>().state;

    if(state.Status != BookFollowsStatus.Loaded){
      return Loading(context);
    }

    return ListView(
        children: [
          Container(
            height: 15,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Image.network(
                      'http://10.0.2.2:3000/images/AMessageFromOurSponsor/AMessageFromOurSponsor_200x300.png',
                      width: 125,
                      height: 188,
                      fit: BoxFit.cover,
                    )
                ),
                Flexible(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Padding(
                              padding: EdgeInsets.fromLTRB(5,5,5,5),
                              child: Text(
                                'A Message From Our Sponsor',
                                style: FlutterFlowTheme.of(context).title1,
                              )
                          )
                        ]
                    )
                ),
              ]
          )
        ]
    );
  }

  Widget Loading(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(),

        CircularProgressIndicator(
          semanticsLabel: 'Loading...',
          color: FlutterFlowTheme.of(context).secondaryColor,
        )
      ],
    );
  }

}
