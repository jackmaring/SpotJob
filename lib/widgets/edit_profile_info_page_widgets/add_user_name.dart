import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_user.dart';

class AddUserName extends StatelessWidget {
  final TextEditingController controller;

  AddUserName(this.controller);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'NAME',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              createUserProvider.name = value;
            },
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
