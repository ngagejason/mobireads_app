import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_bloc.dart';
import 'package:mobi_reads/blocs/app_bloc/app_event.dart';
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


class UserFollowsWidget extends StatefulWidget {
  const UserFollowsWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _UserFollowsWidgetState createState() => _UserFollowsWidgetState();
}

class _UserFollowsWidgetState extends State<UserFollowsWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          'UserFollows'
      )
    );
  }
}
