import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/styles/custom_colors.dart';

class SingleItemCard extends StatelessWidget {
  final String item;
  final bool canDelete;
  final bool isSkill;

  SingleItemCard({
    @required this.item,
    @required this.canDelete,
    this.isSkill,
  });

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final createJobProivder = Provider.of<CreateJob>(context);
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        shadowColor: CustomColors.lightGray,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            '${item[0] + item.substring(1).toLowerCase()}',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
      onDoubleTap: canDelete
          ? isSkill
              ? () => createUserProvider.removeSkill(item)
              : () => createJobProivder.removeTag(item)
          : () {},
    );
  }
}
