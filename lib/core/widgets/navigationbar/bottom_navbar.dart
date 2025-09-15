import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.house),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.users),
      label: "Explore",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.penToSquare),
      label: "Post",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.bell),
      label: "Notifications",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.tableCellsLarge),
      label: "Dashboard",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _items,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue.shade800,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() => _currentIndex = index);
      },
    );
  }
}
