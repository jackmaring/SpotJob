import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/tabs_pages/message_pages/message_page.dart';
import 'package:spotjob/services/crud_models/chat_crud_model.dart';
import 'package:spotjob/services/update_methods/chat_update_methods.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/utils/top_methods/chat_top_methods.dart';
import 'package:spotjob/widgets/common/notification_bubble.dart';

class ProfileDrawer extends StatelessWidget {
  final ChatCRUD chatCrud = ChatCRUD();

  final User relevantUser;
  final User currentUserDoc;

  ProfileDrawer(this.relevantUser, this.currentUserDoc);

  @override
  Widget build(BuildContext context) {
    Chat relevantChat =
        ChatTopMethods.getRelevantChat(context, currentUserDoc, relevantUser);

    return (relevantUser != null && currentUserDoc != null)
        ? Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      '${relevantUser.username}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                !currentUserDoc.connections.contains(relevantUser.id)
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
                          relevantUser,
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
                          relevantUser,
                        ),
                      ),
                relevantChat != null
                    ? StreamProvider(
                        create: (_) =>
                            chatCrud.getChatMessages(relevantChat.id),
                        child: Consumer<List<Message>>(
                          builder: (context, messages, _) {
                            final List<Message> unreadChatMessages =
                                ChatTopMethods.getUnreadChatMessages(
                                    messages, currentUserDoc);
                            return ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    'Message',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  unreadChatMessages.length > 0
                                      ? SizedBox(width: 8)
                                      : Container(),
                                  unreadChatMessages.length > 0
                                      ? NotificationBubble(
                                          '${unreadChatMessages.length}',
                                        )
                                      : Container(),
                                ],
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  FontAwesomeIcons.commentDots,
                                  size: 25,
                                  color: CustomColors.gray,
                                ),
                              ),
                              onTap: () {
                                if (unreadChatMessages.length > 0) {
                                  unreadChatMessages.forEach(
                                    (unreadMessage) =>
                                        ChatUpdateMethods.makeMessageRead(
                                            relevantChat, unreadMessage),
                                  );
                                }
                                List<Map<String, dynamic>> messagePageArgs = [
                                  {'otherUser': relevantUser},
                                  {'relevantChat': relevantChat},
                                ];
                                Navigator.pushNamed(
                                  context,
                                  MessagePage.routeName,
                                  arguments: messagePageArgs,
                                );
                              },
                            );
                          },
                        ),
                      )
                    : ListTile(
                        title: Text(
                          'Message',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            FontAwesomeIcons.commentDots,
                            size: 25,
                            color: CustomColors.gray,
                          ),
                        ),
                        onTap: () {
                          ChatUpdateMethods.createChat(
                            userIds: [currentUserDoc.id, relevantUser.id],
                          ).then(
                            (newChat) {
                              List<Map<String, dynamic>> messagePageArgs = [
                                {'otherUser': relevantUser},
                                {'relevantChat': newChat},
                              ];
                              Navigator.pushNamed(
                                context,
                                MessagePage.routeName,
                                arguments: messagePageArgs,
                              );
                            },
                          );
                        },
                      ),
                !currentUserDoc.blockedUsers.contains(relevantUser.id)
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
                          relevantUser,
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
                          relevantUser,
                        ),
                      ),
              ],
            ),
          )
        : Container();
  }
}
