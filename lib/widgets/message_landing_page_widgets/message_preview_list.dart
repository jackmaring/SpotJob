import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/pages/tabs_pages/message_pages/message_page.dart';
import 'package:spotjob/services/crud_models/chat_crud_model.dart';
import 'package:spotjob/services/update_methods/chat_update_methods.dart';
import 'package:spotjob/utils/top_methods/chat_top_methods.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/utils/useful_methods.dart';
import 'package:spotjob/widgets/common/notification_bubble.dart';

class MessagePreviewList extends StatelessWidget {
  final ChatCRUD chatCrud = ChatCRUD();

  @override
  Widget build(BuildContext context) {
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);
    final List<Chat> chatsUserIsIn =
        ChatTopMethods.getChatsUserIsInWhereVisibleTo(context, currentUserDoc);

    return chatsUserIsIn != null
        ? ListView.separated(
            itemBuilder: (context, index) {
              final Chat currentChat = chatsUserIsIn[index];
              final String otherUserId = currentChat.users.singleWhere(
                (userId) => userId != currentUserDoc.id,
              );
              final User otherUser =
                  UserTopMethods.getUserById(context, otherUserId);
              final Message lastMessage = currentChat.lastMessage;

              final List<Map<String, dynamic>> messagePageArgs = [
                {'otherUser': otherUser},
                {'relevantChat': currentChat},
              ];

              return lastMessage != null
                  ? Dismissible(
                      key: Key(currentChat.id),
                      background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      child: StreamProvider(
                        create: (_) => chatCrud.getChatMessages(currentChat.id),
                        child: Consumer<List<Message>>(
                          builder: (context, messages, _) {
                            final List<Message> unreadChatMessages =
                                ChatTopMethods.getUnreadChatMessages(
                                    messages, currentUserDoc);
                            return ListTile(
                              leading: GestureDetector(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    otherUser.profilePic,
                                  ),
                                  radius: 25,
                                ),
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  ProfilePage.routeName,
                                  arguments: otherUser,
                                ),
                              ),
                              title: Text(
                                otherUser.name.isNotEmpty
                                    ? otherUser.name
                                    : otherUser.username,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              subtitle: Text(
                                UsefulMethods.truncateWithEllipsis(
                                    20, lastMessage.content),
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  unreadChatMessages.length > 0
                                      ? NotificationBubble(
                                          '${unreadChatMessages.length}',
                                        )
                                      : Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                  SizedBox(width: 8),
                                  Text(
                                    DateFormat('h:mm a').format(
                                      lastMessage.dateCreated.toDate(),
                                    ),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                              onTap: () {
                                if (unreadChatMessages.length > 0) {
                                  unreadChatMessages.forEach(
                                    (unreadMessage) =>
                                        ChatUpdateMethods.makeMessageRead(
                                            currentChat, unreadMessage),
                                  );
                                }
                                Navigator.pushNamed(
                                  context,
                                  MessagePage.routeName,
                                  arguments: messagePageArgs,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      onDismissed: (direction) =>
                          ChatUpdateMethods.removeUserFromIsVisibleTo(
                              currentChat, currentUserDoc),
                    )
                  : Container();
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: chatsUserIsIn.length,
          )
        : Container();
  }
}
