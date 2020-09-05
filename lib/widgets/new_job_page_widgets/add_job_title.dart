import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_job.dart';

class AddJobTitle extends StatelessWidget {
  final TextEditingController titleController;

  AddJobTitle(this.titleController);

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TITLE',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: titleController..text = createJobProvider.titleText,
            onChanged: (value) {
              createJobProvider.titleText = value;
            },
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
