import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  Message lastMessage;
  List<String> users;
  List<String> isVisibleTo;

  Chat({
    this.id,
    this.lastMessage,
    this.users,
    this.isVisibleTo,
  });

  Chat.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          lastMessage: Message.fromJson(data['lastMessage']),
          users: data['users'].cast<String>(),
          isVisibleTo: data['isVisibleTo'].cast<String>(),
        );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'lastMessage': this.lastMessage.toJson(),
        'users': this.users,
        'isVisibleTo': this.isVisibleTo,
      };
}

enum MessageType {
  text,
  takeRequest,
  image,
  location,
}

enum MessageStatus {
  read,
  unread,
}

class Message {
  String id;
  String uid;
  String content;
  MessageType messageType;
  MessageStatus messageStatus;
  String chatId;
  Timestamp dateCreated;

  Message({
    this.id,
    this.uid,
    this.content,
    this.messageType,
    this.messageStatus,
    this.chatId,
    this.dateCreated,
  });

  Message.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          uid: data['uid'],
          content: data['content'],
          messageType: _stringToMessageType(data['messageType']),
          messageStatus: _stringToMessageStatus(data['messageStatus']),
          chatId: data['chatId'],
          dateCreated: data['dateCreated'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'content': content,
        'messageType': _messageTypeToString(messageType),
        'messageStatus': _messageStatusToString(messageStatus),
        'chatId': chatId,
        'dateCreated': dateCreated,
      };

  static MessageType _stringToMessageType(String messageType) {
    if (messageType == 'Text') {
      return MessageType.text;
    } else if (messageType == 'Take Request') {
      return MessageType.takeRequest;
    } else if (messageType == 'Image') {
      return MessageType.image;
    } else {
      return MessageType.location;
    }
  }

  static String _messageTypeToString(MessageType messageType) {
    if (messageType == MessageType.text) {
      return 'Text';
    } else if (messageType == MessageType.takeRequest) {
      return 'Take Request';
    } else if (messageType == MessageType.image) {
      return 'Image';
    } else {
      return 'Location';
    }
  }

  static MessageStatus _stringToMessageStatus(String messageStatus) {
    if (messageStatus == 'Read') {
      return MessageStatus.read;
    } else {
      return MessageStatus.unread;
    }
  }

  static String _messageStatusToString(MessageStatus messageStatus) {
    if (messageStatus == MessageStatus.read) {
      return 'Read';
    } else {
      return 'Unread';
    }
  }
}
