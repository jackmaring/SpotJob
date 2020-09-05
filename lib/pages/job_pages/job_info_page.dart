import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/job_info_page_widgets/bottom_job_info_container.dart';
import 'package:spotjob/widgets/job_info_page_widgets/top_job_info_container.dart';

class JobInfoPage extends StatelessWidget {
  static const routeName = '/job-info';

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    final Job relevantJob = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: BackArrowAppBar(
        onPressed: () {
          createJobProvider.resetCreateJobStats();
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 44),
            TopJobInfoContainer(relevantJob),
            BottomJobInfoContainer(relevantJob),
          ],
        ),
      ),
    );
  }
}
