import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/tabs_pages/wallet_page.dart';
import 'package:spotjob/pages/tabs_pages/homepage.dart';
import 'package:spotjob/pages/tabs_pages/job_lists_page.dart';
import 'package:spotjob/pages/tabs_pages/message_pages/message_landing_page.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/tabs_page_widgets/gradient_fab.dart';
import 'package:spotjob/widgets/tabs_page_widgets/tabs_header.dart';

class TabsPage extends StatefulWidget {
  static const routeName = '/tabs-page';

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  final iconList = <IconData>[
    FontAwesomeIcons.home,
    FontAwesomeIcons.clipboard,
    FontAwesomeIcons.comment,
    // FontAwesomeIcons.cog,
    FontAwesomeIcons.wallet,
  ];

  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePage(),
        'title': '',
      },
      {
        'page': JobListsPage(),
        'title': 'Jobs Lists',
      },
      {
        'page': MessageLandingPage(),
        'title': 'Messages',
      },
      {
        'page': WalletPage(),
        'title': 'Settings',
      },
    ];
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);

    return currentUserDoc != null
        ? Scaffold(
            floatingActionButton: GradientFAB(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(129),
              child: SafeArea(
                child: TabsHeader(currentUserDoc),
              ),
            ),
            body: _pages[_selectedPageIndex]['page'],
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: iconList,
              activeColor: Theme.of(context).accentColor,
              inactiveColor: CustomColors.gray,
              splashColor: Theme.of(context).accentColor,
              activeIndex: _selectedPageIndex,
              gapLocation: GapLocation.center,
              notchAndCornersAnimation: animation,
              notchSmoothness: NotchSmoothness.softEdge,
              leftCornerRadius: 25,
              rightCornerRadius: 25,
              onTap: (index) => _selectPage(index),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
