import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/widgets/job_info_page_widgets/top_job_info.dart';

class TopJobInfoContainer extends StatefulWidget {
  final Job relevantJob;

  TopJobInfoContainer(this.relevantJob);

  @override
  _TopJobInfoContainerState createState() => _TopJobInfoContainerState();
}

class _TopJobInfoContainerState extends State<TopJobInfoContainer> {
  final key = GlobalKey<_TopJobInfoContainerState>();

  @override
  initState() {
    super.initState();

    //calling the getHeight Function after the Layout is Rendered
    Future.delayed(
      Duration.zero,
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            final RenderBox renderBox = key.currentContext.findRenderObject();
            final createUserProvider =
                Provider.of<CreateJob>(context, listen: false);
            createUserProvider.jobInfoTopContainerHeight =
                renderBox.size.height;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              TopJobInfo(widget.relevantJob),
            ],
          ),
        ),
      ],
    );
  }
}
