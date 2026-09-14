import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCustom({
    super.key,
    required this.leading,
    required this.title,
    required this.action,
  });
  final Widget leading;
  final String title;
  final Widget action;
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: AppBar(
        leading: IconButton(onPressed: () {}, icon: leading),
        title: Text(title, style: TextStyle(fontSize: 30, fontWeight: .bold)),
        actions: [action],
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 60);
}
