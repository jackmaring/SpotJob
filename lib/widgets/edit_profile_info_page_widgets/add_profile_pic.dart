import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/utils/image_file_picker.dart';

class AddProfilePic extends StatelessWidget {
  final User currentUserDoc;

  AddProfilePic(this.currentUserDoc);

  @override
  Widget build(BuildContext context) {
    final createUserProvider = Provider.of<CreateUser>(context);

    uploadImage() async {
      // Check Permissions
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted) {
        // Select Image
        File profileImg =
            await ImageFilePicker.retrieveAndCropImageFileFromLibrary();
        createUserProvider.profileImg = profileImg;
      } else {
        print('Grant permissions and try again');
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PROFILE PIC',
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            child: CircleAvatar(
              backgroundImage: createUserProvider.profilePicUrl.isNotEmpty
                  ? createUserProvider.profileImg != null
                      ? FileImage(createUserProvider.profileImg)
                      : NetworkImage(currentUserDoc.profilePic)
                  : AssetImage('assets/images/default_profile_pic.jpg'),
              radius: 100,
            ),
            onTap: () => uploadImage(),
          ),
        ),
      ],
    );
  }
}
