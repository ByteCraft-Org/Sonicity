import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify.dart';
import 'package:sonicity/utils/sections/sections.dart';
import 'package:sonicity/utils/widgets/widgets.dart';

class ViewAllSection extends StatelessWidget {
  final double leftPadding, rightPadding;
  final String title;
  final String buttonTitle;
  final VoidCallback onPressed;
  final double size;
  ViewAllSection({
    super.key, required this.title, required this.buttonTitle, required this.onPressed,
    this.leftPadding = 5, this.rightPadding = 10, this.size = 27
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: rightPadding, left: leftPadding),
      child: Row(
        children: [
          TitleSection(title: title, leftPadding: leftPadding, size: size),
          Spacer(),
          ElevatedButton(
            onPressed: onPressed,
            child: Row(
              children: [
                Text(buttonTitle, style: theme.textTheme.labelSmall),
                Iconify(Ic.baseline_keyboard_arrow_right, color: Colors.grey)
              ],
            ),
          )
        ],
      ),
    );
  }
}