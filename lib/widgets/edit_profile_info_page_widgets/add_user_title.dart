import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_user.dart';

class AddUserTitle extends StatelessWidget {
  final TextEditingController controller;

  AddUserTitle(this.controller);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TITLE',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: controller..text = createUserProvider.title,
            onChanged: (value) {
              createUserProvider.title = value;
            },
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
