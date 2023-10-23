import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/history/history_screen.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/home/home_screen.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/setting_screen/setting_screen.dart';

class BottomNaigationBar extends StatefulWidget {
  const BottomNaigationBar({Key? key}) : super(key: key);

  @override
  State<BottomNaigationBar> createState() => _BottomNaigationBarState();
}

class _BottomNaigationBarState extends State<BottomNaigationBar> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    const HistoryScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              notchColor: Colors.black87,
              removeMargins: false,
              // 페이지 이동 시간
              durationInMilliSeconds: 200,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.star,
                    color: Colors.blueAccent,
                  ),
                  itemLabel: 'history',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.add_box,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.add_box,
                    color: Colors.white,
                  ),
                  itemLabel: 'setting',
                ),
              ],
              onTap: (index) {
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}

