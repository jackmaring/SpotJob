import 'package:flutter/material.dart';

import 'package:spotjob/widgets/homepage_widgets/header.dart';
import 'package:spotjob/widgets/homepage_widgets/home_page_scrollable_job_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var safePadding = MediaQuery.of(context).padding.top;
    var bottomPadding = mediaQuery.padding.bottom;
    var appBarHeight = AppBar().preferredSize.height;
    // print(safePadding);
    return Column(
      children: <Widget>[
        Header(),
        Expanded(
          child: HomePageScrollableJobList(),
        ),
      ],
    );
  }
}
