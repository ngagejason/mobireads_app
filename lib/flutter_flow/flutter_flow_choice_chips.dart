import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double _kChoiceChipsHeight = 40.0;

class ChipData {
  const ChipData(this.label, {this.iconData = const IconData(16)});
  final String label;
  final IconData iconData ;
}

class ChipStyle {
  const ChipStyle(
      {this.backgroundColor = const Color(0xFFEACD29),
      this.textStyle = const TextStyle(fontFamily: 'Lexend Deca', color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),
      this.iconColor = const Color(0xFFA7A7A7),
      this.iconSize = 16,
      this.labelPadding = EdgeInsets.zero,
      this.elevation = 4});
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color iconColor;
  final double iconSize;
  final EdgeInsetsGeometry labelPadding;
  final double elevation;
}

class FlutterFlowChoiceChips extends StatefulWidget {
  const FlutterFlowChoiceChips({
    this.initialOption = 'Not Set',
    required this.options,
    required this.onChanged,
    this.selectedChipStyle = const ChipStyle(),
    this.unselectedChipStyle = const ChipStyle(),
    this.chipSpacing = 6
  });

  final String initialOption;
  final List<ChipData> options;
  final void Function(String) onChanged;
  final ChipStyle selectedChipStyle;
  final ChipStyle unselectedChipStyle;
  final double chipSpacing;

  @override
  State<FlutterFlowChoiceChips> createState() => _FlutterFlowChoiceChipsState();
}

class _FlutterFlowChoiceChipsState extends State<FlutterFlowChoiceChips> {
  String choiceChipValue = 'Unknown Chip Value';

  @override
  void initState() {
    super.initState();
    choiceChipValue = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) => Container(
        height: _kChoiceChipsHeight,
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: widget.options.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final selected = option.label == choiceChipValue;
            final style = selected
                ? widget.selectedChipStyle
                : widget.unselectedChipStyle;
            return ChoiceChip(
              selected: selected,
              onSelected: (isSelected) {
                if (isSelected) {
                  choiceChipValue = option.label;
                  widget.onChanged(choiceChipValue);
                  setState(() {});
                }
              },
              label: Text(
                option.label,
                style: style.textStyle,
              ),
              labelPadding: style.labelPadding,
              avatar: option.iconData != null
                  ? FaIcon(
                      option.iconData,
                      size: style.iconSize,
                      color: style.iconColor,
                    )
                  : null,
              elevation: style.elevation,
              selectedColor:
                  selected ? widget.selectedChipStyle.backgroundColor : null,
              backgroundColor:
                  selected ? null : widget.unselectedChipStyle.backgroundColor,
            );
          },
          separatorBuilder: (_, __) => SizedBox(width: widget.chipSpacing),
        ),
      );
}
