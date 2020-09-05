import 'package:flutter/foundation.dart';

enum MessageLandingSearchBy {
  messages,
  allUsers,
}

class Settings with ChangeNotifier {
  MessageLandingSearchBy searchBy = MessageLandingSearchBy.messages;

  void searchByAllUsers() {
    searchBy = MessageLandingSearchBy.allUsers;
    notifyListeners();
  }

  void searchByMessages() {
    searchBy = MessageLandingSearchBy.messages;
    notifyListeners();
  }
}
