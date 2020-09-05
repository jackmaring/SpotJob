import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/styles/custom_colors.dart';

class UserMessage extends StatelessWidget {
  final Message message;
  final bool showTime;
  final bool isFirst;

  UserMessage(
      this.message, this.showTime, this.isFirst);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          isFirst ? Container() : showTime ? SizedBox(height: 20) : Container(),
          showTime
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    DateFormat('h:mm a').format(
                      message.dateCreated.toDate(),
                    ),
                    style: Theme.of(context).textTheme.overline.copyWith(
                        color: CustomColors.gray, fontWeight: FontWeight.w300),
                  ),
                )
              : Container(),
          showTime ? SizedBox(height: 8) : Container(),
          Container(
            padding: EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
            constraints: BoxConstraints(
              maxWidth: (MediaQuery.of(context).size.width * 0.6) - 16,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(
              message.content,
              // textAlign: TextAlign.right,
              style: Theme.of(context)
                  .textTheme
                  .overline
                  .copyWith(color: Colors.white),
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
