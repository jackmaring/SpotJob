import 'package:flutter/material.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/profile_page.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/search_bar.dart';

class ConnectionsPage extends StatelessWidget {
  static const routeName = '/connections';

  @override
  Widget build(BuildContext context) {
    final User relevantUser = ModalRoute.of(context).settings.arguments;
    final List<User> relvantUserConnections =
        UserTopMethods.getUserConnections(context, relevantUser);

    String _searchQuery;

    return relevantUser != null
        ? Scaffold(
            appBar: BackArrowAppBar(
              onPressed: () => Navigator.pop(context),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 73),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${relevantUser.username}\'s',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'CONNECTIONS',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                SearchBar(
                  onChanged: (value) {
                    _searchQuery = value;
                  },
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          'assets/images/circle5.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          relvantUserConnections[index].name != null
                              ? relvantUserConnections[index].name
                              : relvantUserConnections[index].username,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(
                          relvantUserConnections[index].title != null
                              ? relvantUserConnections[index].title
                              : '',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProfilePage.routeName,
                          arguments: relvantUserConnections[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: relvantUserConnections.length,
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
