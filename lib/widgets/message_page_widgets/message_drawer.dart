import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/styles/custom_colors.dart';

class MessageDrawer extends StatelessWidget {
  final User otherUser;
  final User currentUserDoc;

  MessageDrawer(this.otherUser, this.currentUserDoc);

  @override
  Widget build(BuildContext context) {
    return (otherUser != null && currentUserDoc != null)
        ? Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${otherUser.username}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                !currentUserDoc.connections.contains(otherUser.id)
                    ? ListTile(
                        title: Text(
                          'Connect',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.userFriends,
                            size: 25,
                            color: CustomColors.gray,
                          ),
                        ),
                        onTap: () => UserUpdateMethods.toggleConnection(
                          currentUserDoc,
                          otherUser,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          'Unconnect',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.userFriends,
                            size: 25,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onTap: () => UserUpdateMethods.toggleConnection(
                          currentUserDoc,
                          otherUser,
                        ),
                      ),
                !currentUserDoc.blockedUsers.contains(otherUser.id)
                    ? ListTile(
                        title: Text(
                          'Block',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.ban,
                            size: 25,
                            color: CustomColors.gray,
                          ),
                        ),
                        onTap: () => UserUpdateMethods.toggleBlockedUser(
                          currentUserDoc,
                          otherUser,
                        ),
                      )
                    : ListTile(
                        title: Text(
                          'Unblock',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.ban,
                            size: 25,
                            color: Colors.red,
                          ),
                        ),
                        onTap: () => UserUpdateMethods.toggleBlockedUser(
                          currentUserDoc,
                          otherUser,
                        ),
                      ),
              ],
            ),
          )
        : Container();
  }
}
