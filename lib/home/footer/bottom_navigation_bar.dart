import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  GlobalKey<CurvedNavigationBarState> navKey;
  BottomNavBar({
    Key? key,
    required this.navKey,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      key: widget.navKey,
      index: 0,
      height: 60,
      animationCurve: Curves.easeInOut,
      backgroundColor: const Color(0xFFF7F3F0),
      animationDuration: const Duration(milliseconds: 200),
      items: const [
        Icon(Icons.home),
        Icon(Icons.chat),
        Icon(Icons.contact_phone)
      ],
      onTap: (index) {
        setState(() {});
      },
    );
  }
}
