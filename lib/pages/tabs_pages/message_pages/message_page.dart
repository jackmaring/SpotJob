import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/services/crud_models/chat_crud_model.dart';
import 'package:spotjob/services/update_methods/chat_update_methods.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/message_page_widgets/message_drawer.dart';
import 'package:spotjob/widgets/message_page_widgets/message_header.dart';
import 'package:spotjob/widgets/message_page_widgets/message_list.dart';

class MessagePage extends StatefulWidget {
  static const routeName = '/messenger';

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final ChatCRUD chatCrud = ChatCRUD();

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messagePageArgs =
        ModalRoute.of(context).settings.arguments;
    final User otherUser = messagePageArgs[0]['otherUser'];
    Chat currentChat = messagePageArgs[1]['relevantChat'];

    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);

    String _message;

    return StreamProvider<List<Message>>(
      create: (_) => chatCrud.getChatMessages(currentChat.id),
      child: Consumer<List<Message>>(
        builder: (context, messages, child) => Scaffold(
          appBar: BackArrowAppBar(
            onPressed: () {
              if (messages == null) {
                ChatUpdateMethods.deleteChat(currentChat);
              }
              Navigator.pop(context);
            },
          ),
          endDrawer: MessageDrawer(otherUser, currentUserDoc),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 88),
                  child: MessageHeader(otherUser),
                ),
                SizedBox(height: 32),
                currentChat != null
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MessageList(currentUserDoc, messages),
                        ),
                      )
                    : Container(),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            color: CustomColors.lightGray,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: TextField(
                            cursorColor: Theme.of(context).accentColor,
                            style: Theme.of(context).textTheme.overline,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16),
                              suffixIcon: Icon(
                                Icons.mic,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                            controller: messageController,
                            onChanged: (value) {
                              _message = value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        child: Icon(
                          Icons.send,
                          color: Theme.of(context).accentColor,
                          size: 30,
                        ),
                        onTap: () {
                          ChatUpdateMethods.createMessage(
                            messageContent: _message,
                            messageType: MessageType.text,
                            currentUser: currentUserDoc,
                            chat: currentChat,
                          ).then(
                            (newMessage) => ChatUpdateMethods.updateChat(
                              currentChat,
                              newMessage,
                              currentUserDoc,
                              otherUser,
                            ),
                          );
                          _message = '';
                          messageController.clear();
                        },
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
