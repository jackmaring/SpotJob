import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/services/crud_models/user_crud_model.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/common/long_blue_button.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_profile_pic.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_user_bio.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_user_certifications.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_user_name.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_user_skills.dart';
import 'package:spotjob/widgets/edit_profile_info_page_widgets/add_user_title.dart';

class InitialEditProfileInfoPage extends StatelessWidget {
  static const routeName = '/initial-edit-profile-info';

  final userCrud = UserCRUD();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);

    return currentUserDoc != null
        ? Scaffold(
            appBar: BackArrowAppBar(
              onPressed: () => Navigator.pop(context),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 73),
                  BigText('CREATE PROFILE'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 32),
                        AddProfilePic(currentUserDoc),
                        SizedBox(height: 32),
                        AddUserName(nameController),
                        SizedBox(height: 32),
                        AddUserTitle(titleController),
                        SizedBox(height: 32),
                        AddUserBio(bioController),
                        SizedBox(height: 32),
                        AddUserCertifications(),
                        SizedBox(height: 32),
                        AddUserSkills(),
                        SizedBox(height: 32),
                        LongBlueButton(
                          text: 'Create Profile',
                          onTap: () async {
                            await UserUpdateMethods.editUserProfile(
                              createUserProvider,
                              currentUserDoc,
                            );
                            Navigator.pushNamed(context, TabsPage.routeName);
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
