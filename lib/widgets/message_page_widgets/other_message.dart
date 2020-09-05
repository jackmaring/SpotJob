import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:spotjob/models/chat.dart';
import 'package:spotjob/styles/custom_colors.dart';

class OtherMessage extends StatelessWidget {
  final Message message;
  final bool showTime;
  final bool isFirst;

  OtherMessage(this.message, this.showTime, this.isFirst);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isFirst ? Container() : showTime ? SizedBox(height: 20) : Container(),
          showTime
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0),
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
              color: CustomColors.lightGray,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              message.content,
              style: Theme.of(context).textTheme.overline,
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
