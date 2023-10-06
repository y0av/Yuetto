import 'package:flutter/material.dart' hide Image, Gradient;
import 'package:pinball/utils/app_theme.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shadowColor: AppTheme.shadow,
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
