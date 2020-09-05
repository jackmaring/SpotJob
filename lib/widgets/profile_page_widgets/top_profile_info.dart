import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/connections_page.dart';
import 'package:spotjob/providers/create_user.dart';

class TopProfileInfo extends StatelessWidget {
  final User relevantUser;

  TopProfileInfo(this.relevantUser);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final User updatedUser = createUserProvider.updatedUser;

    return Column(
      children: <Widget>[
        SizedBox(height: 32),
        CircleAvatar(
          backgroundImage: NetworkImage(
            updatedUser != null
                ? updatedUser.profilePic
                : relevantUser.profilePic,
          ),
          radius: 100,
        ),
        SizedBox(height: 16),
        Text(
          updatedUser != null
              ? updatedUser.name ?? ''
              : relevantUser.name ?? '',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 8),
        Text(
          updatedUser != null
              ? updatedUser.title ?? ''
              : relevantUser.title ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: 8),
        GestureDetector(
          child: Text(
            relevantUser.connections.length == 1
                ? '${relevantUser.connections.length} Connection'
                : '${relevantUser.connections.length} Connections',
            style: Theme.of(context).textTheme.headline6,
          ),
          onTap: () => Navigator.pushNamed(
            context,
            ConnectionsPage.routeName,
            arguments: relevantUser,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            updatedUser != null
                ? updatedUser.bio ?? ''
                : relevantUser.bio ?? '',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 32),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 48),
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.instagram,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.snapchat,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebookSquare,
                  size: 30,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.linkedin,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
