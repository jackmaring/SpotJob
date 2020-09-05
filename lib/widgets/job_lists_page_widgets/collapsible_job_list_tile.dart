import 'package:flutter/material.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/common/job_list_tile.dart';

class CollapsibleJobListTile extends StatefulWidget {
  final String title;
  final List<Job> jobsList;

  CollapsibleJobListTile(this.title, this.jobsList);

  @override
  _CollapsibleJobListTileState createState() => _CollapsibleJobListTileState();
}

class _CollapsibleJobListTileState extends State<CollapsibleJobListTile> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? (widget.jobsList.length.toDouble() * 100 + 91) : 81,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomColors.gray,
          ),
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          GestureDetector(
            child: ListTile(
              leading: _expanded
                  ? Icon(
                      Icons.do_not_disturb_on,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.add_circle,
                      color: Theme.of(context).accentColor,
                    ),
              title: Text(
                '${widget.title} (${widget.jobsList.length})',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            onTap: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _expanded ? (widget.jobsList.length.toDouble() * 100 + 10) : 0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => JobListTile(
                jobDetails: widget.jobsList[index],
              ),
              itemCount: widget.jobsList.length,
            ),
          ),
        ],
      ),
    );
  }
}
