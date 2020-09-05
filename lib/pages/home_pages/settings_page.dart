import 'package:flutter/material.dart';
import 'package:spotjob/pages/welcome_pages/welcome_page.dart';
import 'package:spotjob/services/auth_service.dart';
import 'package:spotjob/widgets/common/big_text.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText('SETTINGS'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              AuthService().signOut();
              Navigator.of(context).pushNamed(WelcomePage.routeName);
            },
          ),
        ),
      ],
    );
  }
}
