import 'package:flutter/material.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/widgets/take_requests_page_widget/accept_button.dart';

class TakeRequestsRow extends StatelessWidget {
  final User takeRequester;

  TakeRequestsRow(this.takeRequester);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListTile(
              leading: Image.asset(
                'assets/images/circle5.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                takeRequester.name != null
                    ? takeRequester.name
                    : takeRequester.username,
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Text(
                takeRequester.title != null ? takeRequester.title : '',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => Navigator.pushNamed(
                context,
                ProfilePage.routeName,
                arguments: takeRequester,
              ),
            ),
          ),
          SizedBox(width: 16),
          AcceptButton(takeRequester),
        ],
      ),
    );
  }
}
