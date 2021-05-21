// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/home_pages/notifications_page.dart';
import 'package:spotjob/pages/home_pages/settings_page.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/common/notification_bubble.dart';

class TabsHeader extends StatelessWidget {
  final User currentUser;

  TabsHeader(this.currentUser);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 32, bottom: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser.profilePic,
                  ),
                  radius: 32.5,
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  ProfilePage.routeName,
                  arguments: currentUser,
                ),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 4),
                  Text(
                    currentUser.username,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 30,
                      color: CustomColors.darkGray,
                    ),
                    Positioned(
                      left: 13,
                      top: -4,
                      child: NotificationBubble('2'),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, NotificationsPage.routeName);
                },
              ),
              SizedBox(width: 24),
              GestureDetector(
                child: Icon(
                  FontAwesomeIcons.cog,
                  size: 25,
                  color: CustomColors.darkGray,
                ),
                onTap: () {
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
