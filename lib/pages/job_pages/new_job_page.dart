import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
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

class NewJobPage extends StatelessWidget {
  static const routeName = '/new-job';
  final jobCrud = JobCRUD();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // final TextEditingController numOfPeopleController = TextEditingController();

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 32),
                        AddJobTitle(titleController),
                        SizedBox(height: 32),
                        AddJobDescription(descController),
                        // SizedBox(height: 32),
                        // SelectPayType(),
                        SizedBox(height: 32),
                        AddJobPrice(priceController),
                        SizedBox(height: 32),
                        SelectLocationType(),
                        AddJobAddress(addressController),
                        // SizedBox(height: 32),
                        // AddJobNumOfPeople(numOfPeopleController),
                        SizedBox(height: 32),
                        AddJobTags(),
                        SizedBox(height: 32),
                        LongBlueButton(
                          text: 'Create Job',
                          onTap: () {
                            JobUpdateMethods.createJob(
                              createJobProvider,
                              currentUserDoc,
                            );
                            Navigator.pushNamedAndRemoveUntil(
                                context, TabsPage.routeName, (route) => false);
                          },
                        ),
                        SizedBox(height: 48),
                      ],
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
