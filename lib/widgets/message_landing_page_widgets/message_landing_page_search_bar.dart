import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotjob/providers/settings.dart';

import 'package:spotjob/styles/custom_colors.dart';

class MessageLandingPageSearchBar extends StatelessWidget {
  final Function(String) onChanged;

  MessageLandingPageSearchBar({this.onChanged});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<Settings>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              height: 40,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                cursorColor: CustomColors.lightBlue,
                style: TextStyle(
                  fontSize: 14,
                  color: CustomColors.gray,
                  fontWeight: FontWeight.w300,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.only(left: 16),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                    color: CustomColors.gray,
                  ),
                  hintText: settingsProvider.searchBy ==
                          MessageLandingSearchBy.messages
                      ? 'Search messages'
                      : 'Search users',
                  hintStyle: TextStyle(
                    color: CustomColors.gray,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 1,
                      color: CustomColors.gray,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      width: 2,
                      color: CustomColors.gray,
                    ),
                  ),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.comments,
              color:
                  settingsProvider.searchBy == MessageLandingSearchBy.messages
                      ? Theme.of(context).accentColor
                      : CustomColors.gray,
            ),
            onTap: () => settingsProvider.searchByMessages(),
          ),
          SizedBox(width: 16),
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.userFriends,
              color:
                  settingsProvider.searchBy == MessageLandingSearchBy.messages
                      ? CustomColors.gray
                      : Theme.of(context).accentColor,
            ),
            onTap: () => settingsProvider.searchByAllUsers(),
          ),
        ],
      ),
    );
  }
}
