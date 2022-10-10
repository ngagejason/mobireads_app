import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'flutter_flow_theme.dart';

class FFButtonOptions {
  const FFButtonOptions({
    this.elevation,
    this.height,
    this.width,
    this.isPrimaryActionButton,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final double? height;
  final double? width;
  final double? elevation;
  final bool? isPrimaryActionButton;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final double? borderRadius;
  final BorderSide? borderSide;
}

class FFButtonWidget extends StatefulWidget {
  const FFButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.showLoadingIndicator = true,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function() onPressed;
  final FFButtonOptions options;
  final bool showLoadingIndicator;

  @override
  State<FFButtonWidget> createState() => _FFButtonWidgetState();
}

class _FFButtonWidgetState extends State<FFButtonWidget> {
  bool loading = false;

  late ButtonStyle style;

  @override void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.options.isPrimaryActionButton ?? true){
      style = ElevatedButton.styleFrom(
        foregroundColor: FlutterFlowTheme.of(context).secondaryColor,
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: widget.options.elevation ?? 2,
        minimumSize: Size(widget.options.width ?? 130, widget.options.height ?? 50),
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
          fontFamily: 'Poppins',
          color: FlutterFlowTheme.of(context).secondaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:  BorderRadius.circular(widget.options.borderRadius ?? 8),
          side: widget.options.borderSide ?? BorderSide( color: FlutterFlowTheme.of(context).secondaryColor, width: 1, ),
        ),
      );
    }
    else{
      style = ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Color(0xD3FFFFFF),
        elevation: widget.options.elevation ?? 12,
        minimumSize: Size(widget.options.width ?? 130, widget.options.height ?? 50),
        textStyle: FlutterFlowTheme.of(context).subtitle2.override(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.options.borderRadius ?? 8),
          side:
          widget.options.borderSide ?? BorderSide(color: Colors.transparent, width: 1,)
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: Container(
                width: 21,
                height: 21,
                child: CircularProgressIndicator(),
              ),
            )
        )

        : AutoSizeText(
            widget.text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.showLoadingIndicator
        ? () async {
            if (loading) {
              return;
            }
            setState(() => loading = true);
            try {
              await widget.onPressed();
            } catch (e) {
              print('On pressed error:\n$e');
            }
            setState(() => loading = false);
          }
        : () => widget.onPressed();

    return Container(
      height: widget.options.height,
      width: widget.options.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: textWidget,
      ),
    );
  }
}
