import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const MainScreen({super.key, required this.child, required this.currentPath});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
