import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';

class Text extends m.Text {
  const Text(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    m.TextScaler? textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super(
          textScaler: textScaler ?? const m.TextScaler.linear(1),
        );

  const Text.rich(
    super.textSpan, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    m.TextScaler? textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  }) : super.rich(
          textScaler: textScaler ?? const m.TextScaler.linear(1),
        );
}

class TextField extends m.StatelessWidget {
  final m.FocusNode? focusNode;
  final m.TextAlign? textAlign;
  final m.TextInputAction? textInputAction;
  final m.InputDecoration decoration;
  final m.TextInputType? keyboardType;
  final m.TextStyle? style;
  final bool? obscureText;
  final String? obscuringCharacter;
  final int? maxLength;
  final m.ScrollController? scrollController;
  final m.ScrollPhysics? scrollPhysics;
  final void Function(String)? onChanged;
  final int? maxLines;
  final void Function(String)? onSubmitted;
  final m.TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;

  const TextField({
    super.key,
    this.focusNode,
    this.textAlign,
    this.textInputAction,
    this.decoration = const m.InputDecoration(
      contentPadding: m.EdgeInsets.zero,
      border: m.InputBorder.none,
      counterText: '',
    ),
    this.keyboardType,
    this.style,
    this.obscureText,
    this.obscuringCharacter,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.onSubmitted,
    this.scrollPhysics,
    this.scrollController,
    this.controller,
    this.inputFormatters,
    this.enabled,
  });

  @override
  m.Widget build(m.BuildContext context) {
    final mqData = m.MediaQuery.of(context);
    final mqDataNew = mqData.copyWith(textScaler: const m.TextScaler.linear(1));
    return m.MediaQuery(
      data: mqDataNew,
      child: m.TextField(
        focusNode: focusNode,
        textAlignVertical: m.TextAlignVertical.center,
        textAlign: textAlign ?? m.TextAlign.start,
        textInputAction: textInputAction,
        cursorColor: m.Colors.black,
        decoration: decoration,
        keyboardType: keyboardType,
        style: style,
        obscureText: obscureText ?? false,
        maxLength: maxLength,
        maxLines: maxLines,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        scrollPhysics: scrollPhysics,
        scrollController: scrollController,
        controller: controller,
        inputFormatters: inputFormatters,
        enabled: enabled,
      ),
    );
  }
}
