import 'package:flutter/material.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/widgets/message_page_widgets/other_message.dart';
import 'package:spotjob/widgets/message_page_widgets/user_message.dart';

class MessageList extends StatelessWidget {
  final User currentUserDoc;
  final List<Message> messages;

  MessageList(this.currentUserDoc, this.messages);

  @override
  Widget build(BuildContext context) {
    bool getIsUserMessage(int index, Message currentMessage) {
      if (currentUserDoc.uid == currentMessage.uid) {
        return true;
      } else {
        return false;
      }
    }

    bool getIsFirst(int index) {
      if (index == 0) {
        return true;
      } else {
        return false;
      }
    }

    bool getShowTime(int index, Message currentMessage) {
      Message lastMessage;
      if (index > 0) {
        lastMessage = messages[index - 1];
      }

      bool isUserMessage = getIsUserMessage(index, currentMessage);
      bool lastMessageWasUserMessage;
      if (lastMessage != null) {
        lastMessageWasUserMessage =
            currentUserDoc.uid == lastMessage.uid ? true : false;
      }

      if (index == 0) return true;
      if (index > 0) {
        if ((isUserMessage && lastMessageWasUserMessage) ||
            (!isUserMessage && !lastMessageWasUserMessage)) {
          final diff = currentMessage.dateCreated
              .toDate()
              .difference(lastMessage.dateCreated.toDate())
              .inMinutes;
          if (diff >= 5) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      } else {
        return true;
      }
    }

    return messages != null
        ? ListView.builder(
            // shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              Message currentMessage = messages[index];

              bool isUserMessage = getIsUserMessage(index, currentMessage);
              bool showTime = getShowTime(index, currentMessage);
              bool isFirst = getIsFirst(index);

              return isUserMessage
                  ? UserMessage(currentMessage, showTime, isFirst)
                  : OtherMessage(currentMessage, showTime, isFirst);
            },
            itemCount: messages.length,
          )
        : Container();
  }
}
