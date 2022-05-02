import 'dart:collection';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
import 'package:flutter/material.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_bloc.dart';
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_event.dart' as book_follows_events;
import 'package:mobi_reads/blocs/book_follows_bloc/book_follows_state.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_bloc.dart';
import 'package:mobi_reads/blocs/preferences_bloc/preferences_event.dart' as preferences_events;
import 'package:mobi_reads/blocs/preferences_bloc/preferences_state.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/loading_page.dart';
import 'package:mobi_reads/views/user_home/search_area.dart';
import 'package:mobi_reads/views/widgets/peek_list_factory.dart';
import 'package:mobi_reads/views/widgets/preference_chip_list.dart';
import 'package:mobi_reads/views/widgets/expandable_section.dart';
import 'package:mobi_reads/views/widgets/standard_peek_list.dart';
import 'package:mobi_reads/views/widgets/standard_preference_chip.dart';


class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _UserHomeWidgetState createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {

  bool genresOpen = false;
  bool agesOpen = false;
  bool pubTypesOpen = false;
  List<PeekListFactory> peeks = List.empty(growable: true);
  HashMap<String, GlobalKey<StandardPeekState>> peekKeys = new HashMap();

  @override
  void initState() {
    super.initState();
    context.read<PreferencesBloc>().add(preferences_events.InitializePreferences());
    context.read<BookFollowsBloc>().add(book_follows_events.InitializeBookFollows());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PreferencesBloc, PreferencesState>(
            listener: (context, state) {
              if (state.Status == PreferencesStatus.PreferencesLoaded) {
                Iterable<Preference> chips = state.Preferences.where((element) => element.Context == "GENRE");
                for(var chip in chips) {
                    GlobalKey<StandardPeekState> key = new GlobalKey();
                    peekKeys[chip.Id] = key;
                    peeks.add(PeekListFactory(key, chip.Code, chip.Label));
                }
                context.read<PreferencesBloc>().add(preferences_events.Loaded());
              }
            }
        ),
        BlocListener<BookFollowsBloc, BookFollowsState>(
          listener: (context, state) {
            if(state.Status == BookFollowsStatus.BookFollowsLoaded){
              context.read<BookFollowsBloc>().add(book_follows_events.Loaded());
            }
          },
        ),
      ],

      child: BlocBuilder<PreferencesBloc, PreferencesState>(builder: (context, state) {
        return BlocBuilder<BookFollowsBloc, BookFollowsState>(builder: (context, state) {
          if(context.read<PreferencesBloc>().state.Status == PreferencesStatus.Loaded){
            return userHomeUI(context);
          }

          return LoadingPage();
        });
      })
    );
  }

  Widget userHomeUI(BuildContext context) {
    double _appBarHeight = 40;

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          floating: true,
          toolbarHeight: _appBarHeight,
          collapsedHeight: _appBarHeight,
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          expandedHeight: 80,
          onStretchTrigger: () async => { print('stretched') },
          leading: Container(),
          actions: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: IconButton(
                    icon: const Icon(Icons.settings_outlined, color: Color(0xD8EACD29)),
                    tooltip: 'Settings',
                    onPressed: () => { widget.scaffoldKey.currentState!.openDrawer() })
            )
          ],
          pinned: false,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
              background: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                child: Image.asset('assets/images/mobireads_logo_4.png'),
              )
          ),
        ),
        SliverList(delegate: SliverChildListDelegate([
          // Search
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: SearchArea(),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: getPrefsRow(),
          ),
          for(var p in peeks)
            p,
        ])
        )
      ],
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

  Widget getPrefsRow(){
    List<Preference> genrePreferences = context.read<PreferencesBloc>().state.Preferences.where((element) => element.Context == 'GENRE').toList();
    List<Preference> ageGroupsPreferences = context.read<PreferencesBloc>().state.Preferences.where((element) => element.Context == 'AGE_GROUP').toList();
    List<Preference> pubTypesPreferences = context.read<PreferencesBloc>().state.Preferences.where((element) => element.Context == 'PUB_TYPE').toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Column(
          children: [
            Row(
                children: [
                  StandardPreferenceChip(
                      'Genres',
                      (selected) { setState(() { genresOpen = !genresOpen; }); },
                      () { return genresOpen; }
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: StandardPreferenceChip(
                        'Ages',
                        (selected) { setState(() { agesOpen = !agesOpen; }); },
                        () { return agesOpen; }
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,0,0),
                    child: StandardPreferenceChip(
                      'Pub Types',
                      (selected) { setState(() { pubTypesOpen = !pubTypesOpen; }); },
                      () { return pubTypesOpen; }
                    )
                  )
                ]
            ),
            ExpandableSection(
                expand: genresOpen,
                child: PreferenceChipList(
                  onChanged: (chipData) {
                    context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData));
                  },
                  options: genrePreferences,
                )
            ),
            ExpandableSection(
                expand: agesOpen,
                child: PreferenceChipList(
                  onChanged: (chipData) {
                    // Create a list of functions to call
                    List<void Function()> refreshFunctions = List.empty(growable: true);
                    peekKeys.forEach( (key, value) { refreshFunctions.add(() { value.currentState?.doRefresh(); });                            });
                    // toggle the preference chip, and when done each function will be called
                    context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData, functions: refreshFunctions));
                  },
                  options: ageGroupsPreferences,
                )
            ),
            ExpandableSection(
                expand: pubTypesOpen,
                child: PreferenceChipList(
                  onChanged: (chipData) {
                    // Create a list of functions to call
                    List<void Function()> refreshFunctions = List.empty(growable: true);
                    peekKeys.forEach( (key, value) { refreshFunctions.add(() { value.currentState?.doRefresh(); });                            });
                    // toggle the preference chip, and when done each function will be called
                    context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData, functions: refreshFunctions));
                  },
                  options: pubTypesPreferences,
                )
            )
          ]
      )
    );
  }
}
