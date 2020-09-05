import 'package:flutter/material.dart';

class NotificationBubble extends StatelessWidget {
  final String numOfNotifications;

  NotificationBubble(this.numOfNotifications);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          numOfNotifications,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
