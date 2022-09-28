import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_event.dart';
import 'package:mobi_reads/classes/UserFileStorage.dart';
import 'package:mobi_reads/classes/UserKvpStorage.dart';
import 'package:mobi_reads/classes/UserSecureStorage.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/repositories/event_log_repository.dart';
import 'package:mobi_reads/views/reader/reader.dart';
import 'package:mobi_reads/views/user_follows/book_follows_widget2.dart';
import 'package:mobi_reads/views/user_home/user_home_widget.dart';

class MasterScaffoldWidget extends StatefulWidget {
  const MasterScaffoldWidget({Key? key}) : super(key: key);

  @override
  MasterScaffoldWidgetState createState() => MasterScaffoldWidgetState();
}

class MasterScaffoldWidgetState extends State<MasterScaffoldWidget> {
  static final scaffoldKey = GlobalKey<ScaffoldState>();
  static final bottomNavBarKey = GlobalKey(debugLabel: 'bottom_nav_bar_key');

  int _selectedIndex = 0;
  late ReaderBloc _readerBloc;
  late AppBloc _appBloc;

  Timer? _timer;
  int _timerCounter = 0;
  bool stopTimer = false;

  @override
  void initState() {
    super.initState();
    _readerBloc = context.read<ReaderBloc>();
    _appBloc = context.read<AppBloc>();
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

  @override
  void dispose() {
    if(_timer != null){
      _timer!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
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
                UserHomeWidget(scaffoldKey: MasterScaffoldWidgetState.scaffoldKey, bottomNavbarKey: MasterScaffoldWidgetState.bottomNavBarKey),
                BookFollowsWidget2(scaffoldKey: MasterScaffoldWidgetState.scaffoldKey, bottomNavbarKey: MasterScaffoldWidgetState.bottomNavBarKey),
                ReaderPageWidget(scaffoldKey: MasterScaffoldWidgetState.scaffoldKey, bottomNavbarKey: MasterScaffoldWidgetState.bottomNavBarKey)
              ],
              index: _selectedIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              key: bottomNavBarKey,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: _selectedIndex == 0 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: _selectedIndex == 1 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_book_outlined,
                    color: _selectedIndex == 2 ? FlutterFlowTheme.of(context).secondaryColor : Colors.white,
                  ),
                  label: ''
                )
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

    List<ListTile> extraTiles = List.empty(growable: true);
    if(_readerBloc.state.canEdit){

      extraTiles.add(
        new ListTile(
          leading: Icon(Icons.update),
          title: Text('Start Auto Refresh'),
          enabled: _readerBloc.state.book != null,
          onTap: () {
            // Stop existing timer
            if(_timer != null){
              _timer!.cancel();
            }

            // Start new timer
            Timer a = new Timer.periodic(Duration(seconds:5), (Timer timer) {

              // cancel after 10 minutes
              if(this._timerCounter > 120 || stopTimer){
                this._timerCounter = 0;
                _timer!.cancel();
                stopTimer = false;
                return;
              }
              else{
                _readerBloc.add(Refresh());
                this._timerCounter = _timerCounter + 1;
              }
            });

            // Save Timer
            setState(() {
              _timer = a;
            });

            scaffoldKey.currentState!.openEndDrawer();
          },
        )
      );

      extraTiles.add(
        new ListTile(
          leading: Icon(Icons.cancel),
          title: Text('Stop Auto-Refresh'),
          enabled: _readerBloc.state.book != null,
          onTap: () {
            setState(() {
              stopTimer = true;
            });

            scaffoldKey.currentState!.openEndDrawer();
          },
        )
      );
    }

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
                  child: getAvatar(_appBloc.state.Username)
              ),
              /*ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Profile'),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.supervised_user_circle_sharp),
                title: Text('User Accounts'),
                onTap: () => {Navigator.pushNamed(context, "/userAccounts")},
              ),*/
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () =>
                {
                  context.read<AppBloc>().add(UserLoggedOutEvent())
                },
              ),
              ListTile(
                leading: Icon(Icons.ramen_dining),
                title: Text('Clear All Data'),
                onTap: () async { await ClearAll(context); },
              ),
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Refresh Book'),
                onTap: () {
                  context.read<ReaderBloc>().add(Refresh());
                  scaffoldKey.currentState!.openEndDrawer();
                },
              ),
              ListTile(
                leading: Icon(Icons.cloud_upload),
                title: Text('Send State'),
                onTap: () {
                  EventLogRepository.shared.logState(context.read<ReaderBloc>().state);
                  scaffoldKey.currentState!.openEndDrawer();
                },
              ),
              for(var p in extraTiles)
                p,
            ],
          ),
        )
    );
  }

  Future ClearAll(BuildContext context) async {
    await UserSecureStorage.clearAll();
    await UserFileStorage.clearAll();
    await UserKvpStorage.clearAll();
    context.read<AppBloc>().add(UserLoggedOutEvent());
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
