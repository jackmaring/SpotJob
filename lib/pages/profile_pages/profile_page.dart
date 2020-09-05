import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/profile_pages/edit_profile_info_page.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/profile_page_widgets/bottom_profile_container.dart';
import 'package:spotjob/widgets/profile_page_widgets/profile_drawer.dart';
import 'package:spotjob/widgets/profile_page_widgets/top_profile_container.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile-info';

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    // Sometimes the relevant user is the current user
    final User relevantUser = ModalRoute.of(context).settings.arguments;
    // currentUserDoc is only used if isUserProfile is false
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);
    final bool isUserProfile =
        UserTopMethods.isCurrentUser(context, currentUserDoc, relevantUser);

    return (currentUserDoc != null && relevantUser != null)
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: CustomColors.darkGray,
                  ),
                  onPressed: () {
                    createUserProvider.resetCreateUser();
                    Navigator.pop(context);
                  },
                ),
              ),
              centerTitle: true,
              title: Text(
                relevantUser.username,
                style: Theme.of(context).textTheme.headline5,
              ),
              actions: [
                isUserProfile
                    ? Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.userEdit,
                            size: 25,
                            color: CustomColors.darkGray,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              EditProfileInfoPage.routeName,
                            );
                          },
                        ),
                      )
                    : Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: CustomColors.darkGray,
                          ),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ),
                    )
              ],
            ),
            endDrawer: ProfileDrawer(relevantUser, currentUserDoc),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TopProfileContainer(relevantUser),
                  BottomProfileContainer(relevantUser),
                ],
              ),
            ),
          )
        : CircularProgressIndicator();
  }
}
