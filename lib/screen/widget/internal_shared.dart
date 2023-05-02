import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '_widget.dart';

class AppBarSearchTextField extends StatelessWidget {
  const AppBarSearchTextField({
    super.key,
    this.controller,
    this.focusNode,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final cupertinoTheme = context.cupertinoTheme;
    return Container(
      color: cupertinoTheme.barBackgroundColor.withAlpha(0xFF),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: CustomSearchTextField(controller: controller, focusNode: focusNode),
    );
  }
}

class CustomLabelTile extends StatelessWidget {
  const CustomLabelTile({
    super.key,
    this.leading,
    this.onTap,
    this.overlap = false,
    this.subtitle,
    this.title,
    this.trailing,
    this.height = 30.0,
    this.contentPadding,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final double height;
  final EdgeInsetsGeometry? contentPadding;

  final bool overlap;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cupertinoTheme = context.cupertinoTheme;
    return CustomListTile(
      onTap: onTap,
      height: height,
      leading: leading,
      trailing: trailing,
      contentPadding: contentPadding,
      tileColor: overlap ? cupertinoTheme.barBackgroundColor : null,
      subtitle: subtitle != null ? DefaultTextStyle(style: cupertinoTheme.textTheme.textStyle, child: subtitle!) : null,
      title: title != null ? DefaultTextStyle(style: cupertinoTheme.textTheme.tabLabelTextStyle, child: title!) : null,
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.suffix,
    this.prefix,
    this.minLines,
    this.placeholder,
    this.maxLines = 1,
    this.backgroundColor,
  });

  final Color? backgroundColor;
  final String? placeholder;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? label;

  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.theme;
    return PlatformBuilder(
      androidBuilder: (context) {
        return ListTile(
          title: TextField(
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: backgroundColor != null,
              fillColor: backgroundColor,
              hintText: placeholder,
              suffix: suffix,
              prefix: prefix,
              label: label,
            ),
          ),
        );
      },
      builder: (context, platform) {
        return CupertinoListSection(
          backgroundColor: Colors.transparent,
          topMargin: 0.0,
          header: label,
          children: [
            CupertinoTextField(
              decoration: BoxDecoration(color: backgroundColor ?? theme.colorScheme.surface, borderRadius: BorderRadius.circular(12.0)),
              suffix: suffix != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: suffix!) : null,
              prefix: prefix != null ? Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0), child: prefix!) : null,
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 20.0),
              placeholder: placeholder,
              maxLines: maxLines,
              minLines: minLines,
            ),
          ],
        );
      },
    );
  }
}
