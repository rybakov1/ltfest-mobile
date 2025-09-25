import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const MainScreen({super.key, required this.child, required this.currentPath});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _getCurrentIndex(BuildContext context) {
    final String currentPath = GoRouterState.of(context).matchedLocation;
    if (currentPath.startsWith('/home')) return 0;
    if (currentPath.startsWith('/fest')) return 1;
    if (currentPath.startsWith('/lab')) return 2;
    if (currentPath.startsWith('/blog')) return 3;
    if (currentPath.startsWith('/more')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/fest');
        break;
      case 2:
        context.go('/lab');
        break;
      case 3:
        context.go('/blog');
        break;
      case 4:
        context.go('/more');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.only(bottom: 16, top: 16),
      //   color: Palette.white,
      //   child: ClipRRect(
      //     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      //     child: Theme(
      //       data: Theme.of(context).copyWith(
      //         splashColor: Colors.transparent,
      //         highlightColor: Colors.transparent,
      //       ),
      //       child: BottomNavigationBar(
      //         type: BottomNavigationBarType.fixed,
      //         currentIndex: _getCurrentIndex(context),
      //         onTap: (index) => _onTap(context, index),
      //         iconSize: 24,
      //         backgroundColor: Palette.white,
      //         selectedLabelStyle: Styles.b4
      //             .copyWith(fontWeight: FontWeight.w500, color: Palette.black),
      //         showUnselectedLabels: true,
      //         selectedItemColor: Palette.black,
      //         unselectedItemColor: Palette.gray,
      //         unselectedLabelStyle: Styles.b4.copyWith(color: Palette.gray),
      //         items: [
      //           BottomNavigationBarItem(
      //             icon: SvgPicture.asset(
      //               _getCurrentIndex(context) == 0
      //                   ? "assets/icons/bottom_bar/home/home_active.svg"
      //                   : "assets/icons/bottom_bar/home/home.svg",
      //               width: 24,
      //               height: 24,
      //             ),
      //             label: 'Главная',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: SvgPicture.asset(
      //               _getCurrentIndex(context) == 1
      //                   ? "assets/icons/bottom_bar/lt/lt_active.svg"
      //                   : "assets/icons/bottom_bar/lt/lt.svg",
      //               width: 24,
      //               height: 24,
      //             ),
      //             label: 'Фестивали',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: SvgPicture.asset(
      //               _getCurrentIndex(context) == 2
      //                   ? "assets/icons/bottom_bar/lab/lab_active.svg"
      //                   : "assets/icons/bottom_bar/lab/lab.svg",
      //               width: 24,
      //               height: 24,
      //             ),
      //             label: 'Лаборатории',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: SvgPicture.asset(
      //               _getCurrentIndex(context) == 3
      //                   ? "assets/icons/bottom_bar/blog/blog_active.svg"
      //                   : "assets/icons/bottom_bar/blog/blog.svg",
      //               width: 24,
      //               height: 24,
      //             ),
      //             label: 'Новости',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: SvgPicture.asset(
      //               "assets/icons/bottom_bar/more.svg",
      //               width: 24,
      //               height: 24,
      //               colorFilter: _getCurrentIndex(context) == 4
      //                   ? ColorFilter.mode(Palette.black, BlendMode.srcIn)
      //                   : ColorFilter.mode(Palette.gray, BlendMode.srcIn),
      //             ),
      //             label: 'Ещё',
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
