import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/user_follows/user_follows_master_widget.dart';
import 'package:mobi_reads/views/user_home/user_home_widget.dart';
import 'package:mobi_reads/views/user_library/user_library_widget.dart';

class MasterScaffoldWidget extends StatefulWidget {
  const MasterScaffoldWidget({Key? key}) : super(key: key);

  @override
  _MasterScaffoldWidgetState createState() => _MasterScaffoldWidgetState();
}

class _MasterScaffoldWidgetState extends State<MasterScaffoldWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state.Status == AppStatus.LoggedOut) {
            context.read<AppBloc>().add(AppInitializingEvent());
            Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
          }
        },
        child: masterScaffoldUI(context)
    );
  }

  Widget masterScaffoldUI(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            drawer: NavDrawer(context),
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            body: IndexedStack(
              children: <Widget>[
                UserHomeWidget(scaffoldKey: this.scaffoldKey),
                UserLibraryWidget(scaffoldKey: this.scaffoldKey),
                UserFollowsMasterWidget(scaffoldKey: scaffoldKey),
              ],
              index: _selectedIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.local_library,
                    color: _selectedIndex == 1 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
                  ),
                  label: 'Library',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: _selectedIndex == 2 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
                  ),
                  label: 'Favorites',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: FlutterFlowTheme.of(context).secondaryColor,
              backgroundColor: FlutterFlowTheme.of(context).primaryColor,
              onTap: _onItemTapped,
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}
