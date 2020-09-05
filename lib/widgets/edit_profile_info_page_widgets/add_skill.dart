import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_user.dart';

class AddSkill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    TextEditingController skillController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: TextField(
        controller: skillController..text = createUserProvider.skill,
        onChanged: (value) {
          createUserProvider.skill = value;
        },
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
