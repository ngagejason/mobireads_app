import 'package:flutter/material.dart';
import 'package:mobi_reads/views/widgets/preference_chip_list.dart';

class StandardPreferenceChip extends StatelessWidget {
  StandardPreferenceChip(this.label, this.onSelected, this.isSelected) : super();

  String label;
  void Function(bool selected) onSelected;
  bool Function() isSelected;

  PreferenceChipStyle selectedChipStyle = const PreferenceChipStyle(
    backgroundColor: const Color(0xFFEACD29),
    textStyle: const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
    elevation: 4,
  );
  PreferenceChipStyle unselectedChipStyle = const PreferenceChipStyle(
    backgroundColor: Colors.black,
    textStyle: const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
    elevation: 4,
  );

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Text(
            label,
            style: const TextStyle(
                fontFamily: 'Lexend Deca',
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          )
      ),
      selected: isSelected(),
      labelPadding: isSelected() ? selectedChipStyle.labelPadding : unselectedChipStyle.labelPadding,
      onSelected: (bool selected) {
        onSelected(selected);
      },
      // selectedColor:  FlutterFlowTheme.of(context).secondaryColor,
      selectedColor: isSelected() ? selectedChipStyle.backgroundColor : null,
      backgroundColor: isSelected() ? null : unselectedChipStyle.backgroundColor,
      elevation: isSelected() ? selectedChipStyle.elevation : unselectedChipStyle.elevation,
    );
  }
}