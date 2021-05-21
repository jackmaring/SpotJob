import 'package:flutter/material.dart';

import 'package:spotjob/pages/welcome_pages/welcome_page.dart';
import 'package:spotjob/services/auth_service.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/big_text.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackArrowAppBar(
        onPressed: () => Navigator.pop(context),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 73),
          BigText('SETTINGS'),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: RaisedButton(
              child: Text('Logout'),
              onPressed: () {
                AuthService.signOut();
                Navigator.of(context).pushNamed(WelcomePage.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
