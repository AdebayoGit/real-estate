import 'package:flutter/material.dart';

import '../screens/search_screen.dart';
import '../screens/test_screen.dart';

class NavItem {
  static const search = NavItem(Icons.search, "Search", SearchScreen());
  static const messages = NavItem(Icons.sms, "Messages", SizedBox());
  static const home = NavItem(Icons.home, "Home", TestHomeScreen());
  static const favorites = NavItem(Icons.favorite, "Favorites", SizedBox());
  static const profile = NavItem(Icons.person, "Profile", SizedBox());

  final IconData icon;
  final String label;
  final Widget screen;

  const NavItem(this.icon, this.label, this.screen);

  static List<NavItem> get values => [search, messages, home, favorites, profile];
}