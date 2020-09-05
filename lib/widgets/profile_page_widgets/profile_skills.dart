import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/widgets/common/cards_list.dart';

class ProfileSkills extends StatelessWidget {
  final User relevantUser;

  ProfileSkills(this.relevantUser);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final User updatedUser = createUserProvider.updatedUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        relevantUser.skills.isNotEmpty
            ? Text(
                'SKILLS',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
              )
            : Container(),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CardsList(
            updatedUser != null ? updatedUser.skills : relevantUser.skills,
            false,
            true,
          ),
        ),
      ],
    );
  }
}
