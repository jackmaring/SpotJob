import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:spotjob/models/sj_notification.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/services/update_methods/user_update_methods.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/utils/top_methods/user_top_methods.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/common/notification_bubble.dart';

class NotificationsPage extends StatefulWidget {
  static const routeName = '/notifications';

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final currentUser = Provider.of<auth.User>(context, listen: false);
      final List<User> users = Provider.of<List<User>>(context, listen: false);
      User currentUserDoc;

      if (users != null && currentUser != null) {
        currentUserDoc = users.singleWhere(
          (user) => user.uid == currentUser.uid,
        );
      }

      if (Platform.isIOS) {
        _fcm.onIosSettingsRegistered.listen((data) {
          _saveDeviceToken(currentUserDoc);
        });

        _fcm.requestNotificationPermissions(IosNotificationSettings());
      } else {
        _saveDeviceToken(currentUserDoc);
      }
    });

    _fcm.configure(
      onMessage: (message) async {
        print('onMessage: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
      },
      onResume: (message) async {
        print('onResume: $message');
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
        return;
      },
      onLaunch: (message) async {
        print('onLaunch: $message');
        Platform.isAndroid
            ? showNotification(message['notification'])
            : showNotification(message['aps']['alert']);
        return;
      },
    );
    configLocalNotification();
    super.initState();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      Platform.isAndroid ? 'io.spotjob.spotjob' : 'com.spotjob.spotjob',
      'SpotJob',
      'Find ur job bb',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(message);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: message);

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
  }

  _saveDeviceToken(User userDoc) async {
    String fcmToken = await _fcm.getToken();

    if (fcmToken != null) {
      UserUpdateMethods.saveToken(userDoc, fcmToken);
    }
  }

  String displayTimestamp(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime dateCreated = timestamp.toDate();
  }

  @override
  Widget build(BuildContext context) {
    User currentUserDoc = UserTopMethods.getCurrentUserDoc(context);
    List<SJNotification> userSJNotifications =
        UserTopMethods.getUserSJNotifications(context, currentUserDoc);

    return Scaffold(
      appBar: BackArrowAppBar(
        onPressed: () => Navigator.pop(context),
      ),
      body: userSJNotifications != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 73),
                BigText('ALERTS'),
                // SizedBox(height: 32),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      User otherUserDoc = UserTopMethods.getUserById(
                          context, userSJNotifications[index].senderId);
                      SJNotification notification = userSJNotifications[index];
                      DateTime currentDate = DateTime.now();
                      Duration timeagoDuration = currentDate
                          .difference(notification.dateCreated.toDate());
                      DateTime timeagoDateTime =
                          currentDate.subtract(timeagoDuration);
                      return ListTile(
                        contentPadding: EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 32),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            otherUserDoc.profilePic,
                          ),
                          radius: 25,
                        ),
                        title: Text(notification.title),
                        // title: RichText(
                        //   text: TextSpan(
                        //     text: otherUserDoc.name,
                        //     style: TextStyle(
                        //       fontSize: 18,
                        //       color: CustomColors.darkGray,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: ' sent you a message',
                        //         style: TextStyle(
                        //           height: 1.5,
                        //           fontSize: 16,
                        //           color: CustomColors.gray,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        trailing: Text(
                          timeago.format(timeagoDateTime),
                          style: TextStyle(
                            fontSize: 16,
                            color: CustomColors.gray,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onTap: () {},
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemCount: userSJNotifications.length,
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}
