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
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';
import 'package:mobi_reads/views/loading_page.dart';
import 'package:mobi_reads/views/widgets/error_snackbar.dart';
import 'package:mobi_reads/views/widgets/peek_list_factory.dart';
import 'package:mobi_reads/views/widgets/preference_chip_list.dart';
import 'package:mobi_reads/views/widgets/expandable_section.dart';
import 'package:mobi_reads/views/widgets/peek_list.dart';
import 'package:mobi_reads/views/widgets/standard_preference_chip.dart';


class UserHomeWidget extends StatefulWidget {
  const UserHomeWidget({Key? key, required this.scaffoldKey, required this.bottomNavbarKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey bottomNavbarKey;

  @override
  _UserHomeWidgetState createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {

  bool genresOpen = false;
  bool agesOpen = false;
  bool pubTypesOpen = false;
  List<PeekListFactory> peeks = List.empty(growable: true);
  HashMap<String, GlobalKey<PeekState>> peekKeys = new HashMap();
  late PreferencesBloc preferencesBloc;
  late BookFollowsBloc bookFollowsBloc;
  late AppBloc appBloc;
  late ReaderBloc readerBloc;

  @override
  void initState() {
    super.initState();
    preferencesBloc = context.read<PreferencesBloc>();
    bookFollowsBloc = context.read<BookFollowsBloc>();
    appBloc = context.read<AppBloc>();
    readerBloc = context.read<ReaderBloc>();

    preferencesBloc.add(preferences_events.InitializePreferences());
    bookFollowsBloc.add(book_follows_events.InitializeBookFollows());
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
                    GlobalKey<PeekState> key = new GlobalKey();
                    peekKeys[chip.Id] = key;
                    peeks.add(PeekListFactory(key, chip.Code, chip.Label, widget.bottomNavbarKey));
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
            else if(state.Status == BookFollowsStatus.Error){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: ErrorSnackbar(message: state.ErrorMessage)),
              );
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
          stretchTriggerOffset: 100,
          onStretchTrigger: () async {
            print('stretched');
            peekKeys.forEach( (key, value) { value.currentState?.doRefresh(); });
          },
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
         /* Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            child: SearchArea(),
          ),*/
          // Preferences
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: getPrefsRow(),
          ),
          //Peeks
          Column(
            children:[
              for(var p in peeks)
                p,
            ]
          )
        ])
        )
      ],
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StandardPreferenceChip(
                      'Categories',
                          (selected) { setState(() {
                        genresOpen = !genresOpen;
                        agesOpen = false;
                        pubTypesOpen = false;
                      }); },
                          () { return genresOpen; }
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: StandardPreferenceChip(
                          'Ages',
                              (selected) { setState(() {
                                agesOpen = !agesOpen;
                                genresOpen = false;
                                pubTypesOpen = false;
                              }); },
                              () { return agesOpen; }
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(5,0,0,0),
                      child: StandardPreferenceChip(
                          'Pub Types',
                              (selected) { setState(() {
                                pubTypesOpen = !pubTypesOpen;
                                agesOpen = false;
                                genresOpen = false;
                              }); },
                              () { return pubTypesOpen; }
                      )
                  )
                ]
            ),
          ),
          ExpandableSection(
              expand: genresOpen,
              child: PreferenceChipList(
                onChanged: (chipData) {
                  context.read<PreferencesBloc>().add(preferences_events.PreferenceToggled(chipData));
                  peekKeys.forEach( (key, value) {
                    if(!chipData.IsSelected && value.currentState != null && value.currentState?.code == chipData.Code){
                      value.currentState?.doRefresh();
                    }
                  });
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
                  peekKeys.forEach( (key, value) { refreshFunctions.add(() { value.currentState?.doRefresh(); }); });
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
                  peekKeys.forEach( (key, value) { refreshFunctions.add(() { value.currentState?.doRefresh(); }); });
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
