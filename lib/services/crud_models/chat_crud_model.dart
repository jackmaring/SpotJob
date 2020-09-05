import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/services/firestore_api.dart';

class ChatCRUD extends ChangeNotifier {
  FirestoreApi _api = FirestoreApi('/chats');

  // Future<List<Chat>> fetchChats() async {
  //   List<Chat> messages;
  //   var result = await _api.getDataCollection();
  //   messages = result.documents.map((doc) => Chat.fromJson(doc.data)).toList();
  //   return messages;
  // }

  Stream<List<Chat>> getChats() {
    return _api.streamDataCollection().map(
          (snapshot) => snapshot.documents
              .map((document) => Chat.fromJson(document.data))
              .toList(),
        );
  }

  Stream<List<Message>> getChatMessages(String chatId) {
    return _api
        .getCollectionRef()
        .document(chatId)
        .collection('messages')
        .orderBy('dateCreated')
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map((document) => Message.fromJson(document.data))
              .toList(),
        );
  }

  Stream<QuerySnapshot> fetchChatsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Chat> getChatById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Chat.fromJson(doc.data);
  }

  Future removeChat(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateChat(Chat data) async {
    await _api.updateDocument(data.toJson(), data.id);
    return;
  }

  Future updateChatMessage(Chat chat, Message message) async {
    await _api
        .getCollectionRef()
        .document(chat.id)
        .collection('messages')
        .document(message.id)
        .updateData(message.toJson());
    return;
  }

  Future<Chat> addChat(Chat data) async {
    await _api
        .addDocument(data.toJson())
        .then((result) => {
              data.id = result.documentID,
              result.setData({'id': data.id}, merge: true)
            })
        .catchError((e) => {print(e.message)});
    return data;
  }

  Future<Message> addMessage(Chat chat, Message data) async {
    await _api
        .getCollectionRef()
        .document(chat.id)
        .collection('messages')
        .add(data.toJson())
        .then((result) => {
              data.id = result.documentID,
              result.setData({'id': data.id}, merge: true)
            })
        .catchError((e) => {print(e.message)});
    return data;
  }
}
