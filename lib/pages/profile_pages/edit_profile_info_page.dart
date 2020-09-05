import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
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

class EditProfileInfoPage extends StatefulWidget {
  static const routeName = '/edit-profile-info';

  @override
  _EditProfileInfoPageState createState() => _EditProfileInfoPageState();
}

class _EditProfileInfoPageState extends State<EditProfileInfoPage> {
  final userCrud = UserCRUD();

  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final createUserProvider =
          Provider.of<CreateUser>(context, listen: false);
      final currentUser = Provider.of<FirebaseUser>(context, listen: false);
      final List<User> users = Provider.of<List<User>>(context, listen: false);
      User currentUserDoc;

      if (users != null && currentUser != null) {
        currentUserDoc = users.singleWhere(
          (user) => user.uid == currentUser.uid,
        );
      }

      createUserProvider.loadUserData(currentUserDoc);

      nameController.text = currentUserDoc.name;
      titleController.text = currentUserDoc.title;
      bioController.text = currentUserDoc.bio;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);
    final User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);

    return currentUserDoc != null
        ? Scaffold(
            appBar: BackArrowAppBar(
              onPressed: () {
                Navigator.pop(context);
                createUserProvider.resetCreateUser();
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 73),
                  BigText('EDIT INFO'),
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
                          text: 'Edit Profile',
                          onTap: () async {
                            User updatedUser =
                                await UserUpdateMethods.editUserProfile(
                              createUserProvider,
                              currentUserDoc,
                            );
                            createUserProvider.updatedUser = updatedUser;
                            Navigator.pop(context);
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
