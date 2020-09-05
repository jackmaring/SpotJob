import 'package:flutter/material.dart';

import 'package:spotjob/pages/job_pages/job_info_page.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/styles/custom_colors.dart';

class JobListsJobListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      shadowColor: CustomColors.lightGray,
      child: GestureDetector(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: GestureDetector(
              child: Image.asset(
                'assets/images/circle1.png',
                height: 50,
                width: 50,
              ),
              onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            ),
          ),
          title: Text(
            'A job title',
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: GestureDetector(
            onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            child: GestureDetector(
              child: Text(
                'test@test.com',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            ),
          ),
          trailing: Text(
            '\$45',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        onTap: () => Navigator.pushNamed(context, JobInfoPage.routeName),
      ),
    );
  }
}
