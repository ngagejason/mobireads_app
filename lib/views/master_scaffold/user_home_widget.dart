import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:mobi_reads/blocs/app_bloc/app_state.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_event.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/PreferenceChip.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/loading_page.dart';
import 'package:mobi_reads/views/user_home/search_area.dart';
import 'package:mobi_reads/views/widgets/peek_list_factory.dart';
import 'package:mobi_reads/views/widgets/preference_chip_list.dart';
import 'package:mobi_reads/views/widgets/preferences_expansion_tile.dart';


class MasterScaffoldWidget extends StatefulWidget {
  const MasterScaffoldWidget({Key? key}) : super(key: key);

  @override
  _MasterScaffoldWidgetState createState() => _MasterScaffoldWidgetState();
}

class _MasterScaffoldWidgetState extends State<MasterScaffoldWidget> {
  String? choiceChipsValue;
  TextEditingController? textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<PeekListFactory> peeks = List.empty(growable: true);
  bool preferencesOpen = false;
  final GlobalKey<PreferencesExpansionTileState> preferencesExpansionTileKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    PreferencesState state = context.read<PreferencesBloc>().state;
    context.read<PreferencesBloc>().add(Initialize());
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
    List<PreferenceChip> preferences = context.read<PreferencesBloc>().state.PreferenceChips.where((element) => element.Context == 'HOME').toList();
    double _appBarHeight = 40;


    return SafeArea(
      child: BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {
        return Scaffold(
            key: scaffoldKey,
            drawer: NavDrawer(context),
            backgroundColor: FlutterFlowTheme.of(context).primaryColor,
            body: Container();
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
}
