import 'package:flutter/material.dart';
import 'package:mobi_reads/entities/preferences/Preference.dart';

class PreferenceChipStyle {
  const PreferenceChipStyle(
      {this.backgroundColor = const Color(0xFFEACD29),
        this.textStyle = const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
        this.labelPadding = EdgeInsets.zero,
        this.elevation = 4});
  final Color backgroundColor;
  final TextStyle textStyle;
  final EdgeInsetsGeometry labelPadding;
  final double elevation;
}


class PreferenceChipList extends StatefulWidget {
  const PreferenceChipList({
    required this.options,
    required this.onChanged,
    this.chipSpacing = 6,

    this.selectedChipStyle = const PreferenceChipStyle(
      backgroundColor: const Color(0xFFEACD29),
      textStyle: const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
      elevation: 4,
    ),

    this.unselectedChipStyle = const PreferenceChipStyle(
      backgroundColor: Colors.black,
      textStyle: const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
      elevation: 4,
    )
  });

  final List<Preference> options;
  final void Function(Preference) onChanged;
  final PreferenceChipStyle selectedChipStyle;
  final PreferenceChipStyle unselectedChipStyle;
  final double chipSpacing;

  @override
  State<PreferenceChipList> createState() => _PreferenceChipListState(options, onChanged);
}

class _PreferenceChipListState extends State<PreferenceChipList> {
  String choiceChipValue = 'Unknown Chip Value';
  List<Preference> options = List.empty(growable: true);
  void Function(Preference) onChanged;

  _PreferenceChipListState(this.options, this.onChanged): super();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding:EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),
      child:Wrap(
        alignment: WrapAlignment.start,
        children: options.map((i) =>
            Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 0),
                child: ChoiceChip(
                  label: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Text(
                        i.Label,
                        style: i.IsSelected ? widget.selectedChipStyle.textStyle : widget.unselectedChipStyle.textStyle,
                      )
                  ),

                  selected: i.IsSelected,
                  labelPadding: i.IsSelected ? widget.selectedChipStyle.labelPadding : widget.unselectedChipStyle.labelPadding,
                  onSelected: (isSelected) => { onChanged(i) },
                  selectedColor: i.IsSelected ? widget.selectedChipStyle.backgroundColor : null,
                  backgroundColor: i.IsSelected ? null : widget.unselectedChipStyle.backgroundColor,
                  elevation: i.IsSelected ? widget.selectedChipStyle.elevation : widget.unselectedChipStyle.elevation,
                )
            )

        ).toList(),
      )
    );
}
