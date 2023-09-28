import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/history_screen.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/home_screen.dart';
import 'package:flutter_ocean_radiation_level/presentation/pags/setting_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      HomeScreen(),
    const Page2(),
    const Page3(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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


        /// restart app if you change removeMargins
        removeMargins: false,
        bottomBarWidth: 700,
        durationInMilliSeconds: 400,
        bottomBarItems: const [
           BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,size: 30,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,size: 30,
              color: Colors.blueAccent,
            ),
            itemLabel: 'home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.star, size: 30,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.star,size: 30,
              color: Colors.blueAccent,
            ),
            itemLabel: 'history',
          ),

          BottomBarItem(
            inActiveItem: Icon(
              Icons.add_box,size: 30,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.add_box,size: 30,
              color: Colors.white,
            ),
            itemLabel: 'setting',
          ),

        ],
        onTap: (index) {
          /// perform action on tab change and to update pages you can update pages without pages
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
      )
          : null,
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow, child: const Center(child: Text('Page 1')));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green, child: const Center(child: Text('Page 2')));
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.red, child: const Center(child: Text('Page 3')));
  }
}

