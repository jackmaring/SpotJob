import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_user.dart';

class AddUserBio extends StatelessWidget {
  final TextEditingController controller;

  AddUserBio(this.controller);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'BIO',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            // controller: controller,
            controller: controller..text = createUserProvider.bio,
            onChanged: (value) {
              createUserProvider.bio = value;
            },
            style: Theme.of(context).textTheme.headline5,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
