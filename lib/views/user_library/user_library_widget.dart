import 'package:flutter/material.dart';


class UserLibraryWidget extends StatefulWidget {
  const UserLibraryWidget({Key? key, required this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _UserLibraryWidgetState createState() => _UserLibraryWidgetState();
}

class _UserLibraryWidgetState extends State<UserLibraryWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          'UserLibrary'
      )
    );
  }
}
