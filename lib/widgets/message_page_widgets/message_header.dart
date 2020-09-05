import 'package:flutter/material.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/styles/custom_colors.dart';

class MessageHeader extends StatelessWidget {
  final User otherUser;

  MessageHeader(this.otherUser);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage(otherUser.profilePic),
                radius: 37.5,
              ),
              onTap: () => Navigator.pushNamed(
                context,
                ProfilePage.routeName,
                arguments: otherUser,
              ),
            ),
            SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Say hello to',
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColors.gray,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  otherUser.name.isNotEmpty
                      ? otherUser.name
                      : otherUser.username,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert,
            size: 30,
          ),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ],
    );
  }
}
