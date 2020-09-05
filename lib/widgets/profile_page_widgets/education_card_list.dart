import 'package:flutter/material.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/widgets/profile_page_widgets/education_card.dart';

class EducationCardList extends StatelessWidget {
  final List<Certification> certifications;
  final bool canDelete;

  EducationCardList(this.certifications, this.canDelete);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return EducationCard(certifications[index], canDelete);
      },
      itemCount: certifications.length,
    );
  }
}
