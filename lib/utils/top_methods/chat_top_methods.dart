import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/user.dart';

class ChatTopMethods {
  static Chat getRelevantChat(
      BuildContext context, User currentUser, User otherUser) {
    final List<Chat> chats = Provider.of<List<Chat>>(context);
    Chat relevantChat;

    if (chats != null) {
      relevantChat = chats.singleWhere(
          (chat) =>
              chat.users.contains(currentUser.id) &&
              chat.users.contains(otherUser.id),
          orElse: () => null);
    }

    return relevantChat;
  }

  static List<Chat> getChatsUserIsInWhereVisibleTo(
      BuildContext context, User currentUser) {
    final List<Chat> chats = Provider.of<List<Chat>>(context);
    List<Chat> chatsUserIsIn;

    if (chats != null) {
      chatsUserIsIn = chats
          .where((chat) =>
              chat.users.contains(currentUser.id) &&
              chat.isVisibleTo.contains(currentUser.id))
          .toList();

      chatsUserIsIn.sort((b, a) =>
          a.lastMessage.dateCreated.compareTo(b.lastMessage.dateCreated));
    }

    return chatsUserIsIn;
  }

  static List<Message> getUnreadChatMessages(
      List<Message> chatMessages, User currentUser) {
    List<Message> unreadChatMessages;

    if (chatMessages != null) {
      unreadChatMessages = chatMessages
          .where((message) =>
              message.messageStatus == MessageStatus.unread &&
              message.uid != currentUser.uid)
          .toList();
    } else {
      unreadChatMessages = [];
    }

    return unreadChatMessages;
  }
}
