import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/widgets/common/spotjob_bottom_sheet.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_certification.dart';
import 'package:spotjob/widgets/profile_page_widgets/education_card_list.dart';

class AddUserCertifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'ADD EDUCATION/CERTIFICATION',
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
                  title: 'ADD EDUCATION',
                  child: AddCertification(),
                  onTap: () {
                    createUserProvider.addCertification(
                      Certification(
                        degree: createUserProvider.degree,
                        institution: createUserProvider.institution,
                        educationType: createUserProvider.educationType,
                      ),
                    );
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: EducationCardList(createUserProvider.certifications, true),
        ),
      ],
    );
  }
}
