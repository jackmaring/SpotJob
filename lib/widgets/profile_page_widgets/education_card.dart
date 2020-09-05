import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/styles/custom_colors.dart';

class EducationCard extends StatelessWidget {
  final Certification certification;
  final bool canDelete;

  EducationCard(this.certification, this.canDelete);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);

    return Card(
      margin: EdgeInsets.only(left: 24, right: 24, bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      shadowColor: CustomColors.lightGray,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        leading: Container(
          padding: EdgeInsets.only(left: 6),
          height: double.infinity,
          child: Icon(
            certification.educationType == EducationType.diploma
                ? FontAwesomeIcons.graduationCap
                : FontAwesomeIcons.certificate,
            size: 30,
            color: CustomColors.gray,
          ),
        ),
        title: Text(
          certification.degree,
          style: Theme.of(context).textTheme.headline5,
        ),
        subtitle: Text(
          certification.institution,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: canDelete
            ? Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                  child: Icon(
                    FontAwesomeIcons.trash,
                    color: Colors.red,
                    size: 25,
                  ),
                  onTap: () =>
                      createUserProvider.removeCertification(certification),
                ),
            )
            : Container(
                height: 1,
                width: 1,
              ),
      ),
    );
  }
}
