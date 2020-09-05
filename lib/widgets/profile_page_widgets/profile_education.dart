import 'package:flutter/material.dart';
import 'package:provider/provider.dart'
;
import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/widgets/profile_page_widgets/education_card_list.dart';

class ProfileEducation extends StatelessWidget {
  final User relevantUser;

  ProfileEducation(this.relevantUser);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final User updatedUser = createUserProvider.updatedUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        relevantUser.certifications.isNotEmpty
            ? Text(
                'EDUCATION & CERTIFICATIONS',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white),
              )
            : Container(),
        SizedBox(height: 16),
        EducationCardList(
          updatedUser != null
              ? updatedUser.certifications
              : relevantUser.certifications,
          false,
        ),
      ],
    );
  }
}
