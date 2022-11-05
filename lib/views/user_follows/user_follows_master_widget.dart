import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/user_follows/book_follows_widget.dart';

class UserFollowsMasterWidget extends StatefulWidget {
  const UserFollowsMasterWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _UserFollowsMasterWidgetState createState() => _UserFollowsMasterWidgetState();
}

class _UserFollowsMasterWidgetState extends State<UserFollowsMasterWidget> {

  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return TabBarView2();
  }

  Widget TabBarView2(){
   return Container(
     padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
     color: FlutterFlowTheme.of(context).primaryColor,
     child: ContainedTabBarView(
       tabs: [
         Tab(
             icon: Icon(
               Icons.my_library_books_sharp,
               color: _index == 0 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
             ),
             text: 'Books'
         ),
         /*Tab(
             icon: Icon(
               Icons.keyboard_outlined,
               color: _index == 1 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
             ),
             text: 'Authors'
         ),*/
       ],
       views: [
         BookFollowsWidget(),
         //UserFollowsAuthorsWidget(),
       ],
       tabBarViewProperties: TabBarViewProperties(
         physics: NeverScrollableScrollPhysics(),
       ),
       tabBarProperties: TabBarProperties(
         isScrollable: false,
         labelColor: FlutterFlowTheme.of(context).secondaryColor,
         unselectedLabelColor: Colors.white,
       ),
       onChange: (index) => setState(() => _index = index),
     )
    ) ;
  }
}
