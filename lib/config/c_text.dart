import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? fWeight;
  final TextAlign? ali;
  final TextDecoration? decoration;
  final TextDecorationStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const CText({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.size,
    this.ali,
    this.fWeight,
    this.decoration,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: ali,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.inter(
        color: color,
        fontSize: size,
        fontWeight: fWeight,
        decoration: decoration,
        decorationColor: color,
        decorationStyle: style,
      ),
    );
  }
}
