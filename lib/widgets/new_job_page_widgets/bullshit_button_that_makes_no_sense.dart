import 'package:flutter/material.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/services/update_methods/job_update_methods.dart';
import 'package:spotjob/widgets/common/long_blue_button.dart';

class BullshitButtonThatMakesNoSense extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final CreateJob createJobProvider;
  final User currentUserDoc;

  BullshitButtonThatMakesNoSense(
      this.formKey, this.createJobProvider, this.currentUserDoc);

  @override
  Widget build(BuildContext context) {
    return LongBlueButton(
      text: 'Create Job',
      onTap: () {
        if (createJobProvider.tags.isEmpty) {
          final snackBar = SnackBar(
            content: Text('Please choose some tags!'),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        } else {
          if (formKey.currentState.validate()) {
            JobUpdateMethods.createJob(
              context,
              createJobProvider,
              currentUserDoc,
            );
          }
        }
      },
    );
  }
}
