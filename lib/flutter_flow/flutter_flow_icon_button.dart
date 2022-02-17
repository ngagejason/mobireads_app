import 'package:flutter/material.dart';

class FlutterFlowIconButton extends StatelessWidget {
  const FlutterFlowIconButton(
      {Key? key,
      this.borderColor = const Color(0xFFEACD29),
      this.borderRadius = 30,
      this.borderWidth = 2,
      this.buttonSize = 46,
      this.fillColor = const Color(0xFF113e82),
      this.icon = const Icon(Icons.search_outlined, color: Colors.white, size: 16),
      this.onPressed
      })
      : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final Widget icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => Material(
        borderRadius:
            borderRadius != null ? BorderRadius.circular(borderRadius) : null,
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Ink(
          width: buttonSize,
          height: buttonSize,
          decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius)
                : null,
          ),
          child: IconButton(
            icon: icon,
            onPressed: onPressed,
            splashRadius: buttonSize,
          ),
        ),
      );
}
