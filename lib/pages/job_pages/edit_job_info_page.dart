import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/services/crud_models/job_crud_model.dart';
import 'package:spotjob/services/update_methods/job_update_methods.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/common/long_blue_button.dart';
import 'package:spotjob/widgets/common/long_white_button.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_address.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_description.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_location_type.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_price.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_tags.dart';
import 'package:spotjob/widgets/new_job_page_widgets/add_job_title.dart';

class EditJobInfoPage extends StatefulWidget {
  static const routeName = '/edit-job-info';

  @override
  _EditJobInfoPageState createState() => _EditJobInfoPageState();
}

class _EditJobInfoPageState extends State<EditJobInfoPage> {
  final jobCrud = JobCRUD();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  // TextEditingController numOfPeopleController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final Job relevantJob = ModalRoute.of(context).settings.arguments;
      final createJobProvider = Provider.of<CreateJob>(context, listen: false);

      createJobProvider.loadJobData(relevantJob);

      titleController.text = relevantJob.title;
      descController.text = relevantJob.description;
      priceController.text = relevantJob.pay.toString();
      addressController.text = relevantJob.address;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Job relevantJob = ModalRoute.of(context).settings.arguments;
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
                  BigText('EDIT JOB'),
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
                          text: 'Edit Job',
                          onTap: () async {
                            Job updatedJob =
                                await JobUpdateMethods.updateJobInfo(
                              createJobProvider,
                              relevantJob,
                            );
                            createJobProvider.updatedJob = updatedJob;
                            Navigator.pop(context);
                          },
                        ),
                        LongWhiteButton(
                          text: 'Delete Job',
                          onTap: () {
                            JobUpdateMethods.deleteJob(
                              createJobProvider,
                              currentUserDoc,
                              relevantJob,
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
        : CircularProgressIndicator();
  }
}
