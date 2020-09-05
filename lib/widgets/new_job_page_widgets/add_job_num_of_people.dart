import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_job.dart';

class AddJobNumOfPeople extends StatelessWidget {
  final TextEditingController numOfPeopleController;

  AddJobNumOfPeople(this.numOfPeopleController);

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PEOPLE NEEDED',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: numOfPeopleController
              ..text = createJobProvider.numOfPeople,
            onChanged: (value) {
              createJobProvider.numOfPeople = value;
            },
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
