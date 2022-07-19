import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobi_reads/blocs/reader_bloc/reader_bloc.dart';
import 'package:mobi_reads/extension_methods/string_extensions.dart';
import 'package:mobi_reads/flutter_flow/flutter_flow_theme.dart';

class ReaderSettingsWidget extends StatefulWidget {

  const ReaderSettingsWidget({Key? key}) : super(key: key);

  @override
  ReaderSettingsWidgetState createState() => ReaderSettingsWidgetState();
}

class ReaderSettingsWidgetState extends State<ReaderSettingsWidget> {

  late int selectedChapter;
  late ReaderBloc readerBloc;

  @override initState(){
    readerBloc = context.read<ReaderBloc>();
    selectedChapter = 0;
    super.initState();
  }

  Widget getTitle(){
    String title = readerBloc.state.allChapters[selectedChapter].Title ?? 'Unnamed Chapter';
    return Text(
        title,
        style: FlutterFlowTheme.of(context).bodyText1.override(
          fontFamily: 'Poppins',
          color: FlutterFlowTheme.of(context).secondaryColor,
          fontSize: 24,
        )
    );
  }

  Widget getPicker(){
    return SizedBox(
        height:300,
        child: CupertinoPicker(
            onSelectedItemChanged: (int value) {
               setState(() => this.selectedChapter = value);
            },
            itemExtent: 48,
            children: readerBloc.state.allChapters.map((element) =>
                Text(
                  element.Title.guarantee(),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).secondaryColor,
                    fontSize: 24,
                  ),
                ),
            ).toList()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getTitle(),
            getPicker()
          ],
        )
    );
  }
}


