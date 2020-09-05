import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/widgets/common/cards_list.dart';
import 'package:spotjob/widgets/common/spotjob_bottom_sheet.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_skill.dart';

class AddUserSkills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'ADD SKILL',
              style: Theme.of(context).textTheme.headline5,
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 25,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                SpotjobBottomSheet.spotjobBottomSheet(
                  context: context,
                  title: 'ADD SKILL',
                  child: AddSkill(),
                  onTap: () {
                    createUserProvider.addSkill(createUserProvider.skill);
                    createUserProvider.skill = '';
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CardsList(createUserProvider.skills, true, true),
        ),
        SizedBox(height: 16),
        createUserProvider.skills.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '(double tap to delete)',
                  style: Theme.of(context).textTheme.headline6,
                ),
              )
            : Container(),
      ],
    );
  }
}
