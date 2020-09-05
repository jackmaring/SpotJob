import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/widgets/common/blue_button.dart';
import 'package:spotjob/widgets/common/white_button.dart';

class AddCertification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    EducationType educationType = createUserProvider.educationType;

    TextEditingController degreeController = TextEditingController();
    TextEditingController institutionController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEGREE',
            style: Theme.of(context).textTheme.headline5,
          ),
          TextField(
            controller: degreeController..text = createUserProvider.degree,
            onChanged: (value) {
              createUserProvider.degree = value;
            },
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 32),
          Text(
            'SCHOOL',
            style: Theme.of(context).textTheme.headline5,
          ),
          TextField(
            controller: institutionController
              ..text = createUserProvider.institution,
            onChanged: (value) {
              createUserProvider.institution = value;
            },
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 32),
          Text(
            'PAY TYPE',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                educationType == EducationType.certificate
                    ? WhiteButton(
                        text: 'Diploma',
                        onTap: () {
                          createUserProvider.educationType =
                              EducationType.diploma;
                        },
                      )
                    : BlueButton(
                        text: 'Diploma',
                        onTap: () {},
                      ),
                educationType == EducationType.certificate
                    ? BlueButton(
                        text: 'Certificate',
                        onTap: () {},
                      )
                    : WhiteButton(
                        text: 'Certificate',
                        onTap: () {
                          createUserProvider.educationType =
                              EducationType.certificate;
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
