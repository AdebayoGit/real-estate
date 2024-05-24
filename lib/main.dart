import 'package:app/widgets/bottom_nav_item.dart';
import 'package:flutter/material.dart';

import 'models/nav_item_models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  NavItem _selectedItem = NavItem.home;  // Use NavItem instead of NavEnum

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.88, 1.0, curve: Curves.easeInSine),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _selectedItem.screen,  // Directly use the screen from NavItem
      ),
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32).copyWith(bottom: 32),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFF191919),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: NavItem.values.map((item) => SizedBox(
              width: 48,
              height: 48,
              child: BottomNavItem(
                iconData: item.icon,
                isActive: item == _selectedItem,
                onPressed: () {
                  setState(() {
                    _selectedItem = item;
                  });
                },
              ),
            )).toList(),
          ),
        ),
      ),
    );
  }
}

