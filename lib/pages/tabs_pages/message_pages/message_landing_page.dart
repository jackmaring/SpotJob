import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/settings.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/message_landing_page_widgets/message_landing_page_search_bar.dart';
import 'package:spotjob/widgets/message_landing_page_widgets/message_preview_list.dart';

class MessageLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<Settings>(context);

    String _searchQuery;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        settingsProvider.searchBy == MessageLandingSearchBy.messages
            ? BigText('MESSAGES')
            : BigText('USERS'),
        MessageLandingPageSearchBar(
          onChanged: (value) {
            _searchQuery = value;
          },
        ),
        SizedBox(height: 16),
        settingsProvider.searchBy == MessageLandingSearchBy.messages
            ? Expanded(
                child: MessagePreviewList(),
              )
            : Expanded(
                child: Container(),
              ),
      ],
    );
  }
}
