import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/services/crud_models/job_crud_model.dart';
import 'package:spotjob/services/update_methods/job_update_methods.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/common/long_blue_button.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_address.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_description.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_location_type.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_price.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_tags.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_title.dart';
import 'package:spotjob/widgets/new_job_page_widgets/bullshit_button_that_makes_no_sense.dart';

class NewJobPage extends StatefulWidget {
  static const routeName = '/new-job';

  @override
  _NewJobPageState createState() => _NewJobPageState();
}

class _NewJobPageState extends State<NewJobPage> {
  final jobCrud = JobCRUD();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    final currentUserDoc = UserTopMethods.getCurrentUserDoc(context);

    return currentUserDoc != null
        ? Scaffold(
            appBar: BackArrowAppBar(
              onPressed: () {
                createJobProvider.resetCreateJobStats();
                Navigator.pop(context);
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 73),
                  BigText('CREATE JOB'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 32),
                            AddJobTitle(),
                            SizedBox(height: 32),
                            AddJobDescription(),
                            SizedBox(height: 32),
                            // SelectPayType(),
                            // SizedBox(height: 32),
                            AddJobPrice(),
                            SizedBox(height: 32),
                            SelectLocationType(),
                            AddJobAddress(),
                            // SizedBox(height: 32),
                            // AddJobNumOfPeople(numOfPeopleController),
                            SizedBox(height: 32),
                            AddJobTags(),
                            SizedBox(height: 32),
                            LongBlueButton(
                              text: 'Create Job',
                              onTap: () {
                                BullshitButtonThatMakesNoSense(
                                  _formKey,
                                  createJobProvider,
                                  currentUserDoc,
                                );
                                if (createJobProvider.tags.isEmpty) {
                                  final snackBar = SnackBar(
                                    content: Text('Please choose some tags!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  if (_formKey.currentState.validate()) {
                                    JobUpdateMethods.createJob(
                                      context,
                                      createJobProvider,
                                      currentUserDoc,
                                    );
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 48),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
