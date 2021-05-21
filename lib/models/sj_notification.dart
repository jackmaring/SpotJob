import 'package:cloud_firestore/cloud_firestore.dart';

enum NotificationType {
  message,
  connectionRequest,
  application,
  takeRequestConfirmation,
  userCompletedJob,
  jobCancellation,
  dev
}

enum NotificationStatus {
  unread,
  read,
  clicked,
}

class SJNotification {
  String id;
  String receiverId;
  String senderId;
  NotificationType notificationType;
  NotificationStatus notificationStatus;
  String title;
  String content;
  Timestamp dateCreated;

  SJNotification({
    this.id,
    this.receiverId,
    this.senderId,
    this.notificationType,
    this.notificationStatus,
    this.title,
    this.content,
    this.dateCreated,
  });

  SJNotification.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          receiverId: data['receiverId'],
          senderId: data['senderId'],
          notificationType: _stringToNotificationType(data['content']),
          notificationStatus: _stringToNotificationStatus(data['messageType']),
          title: data['title'],
          content: data['content'],
          dateCreated: data['dateCreated'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'receiverId': receiverId,
        'senderId': senderId,
        'notificationType': _notificationTypeToString(notificationType),
        'notificationStatus': _notificationStatusToString(notificationStatus),
        'title': title,
        'content': content,
        'dateCreated': dateCreated,
      };

  static NotificationType _stringToNotificationType(String notificationType) {
    if (notificationType == 'Message') {
      return NotificationType.message;
    } else if (notificationType == 'Connection Request') {
      return NotificationType.connectionRequest;
    } else if (notificationType == 'Application') {
      return NotificationType.application;
    } else if (notificationType == 'Take Request Confirmation') {
      return NotificationType.takeRequestConfirmation;
    } else if (notificationType == 'User Completed Job') {
      return NotificationType.userCompletedJob;
    } else if (notificationType == 'Job Cancellation') {
      return NotificationType.jobCancellation;
    } else {
      return NotificationType.dev;
    }
  }

  static String _notificationTypeToString(NotificationType notificationType) {
    if (notificationType == NotificationType.message) {
      return 'Message';
    } else if (notificationType == NotificationType.connectionRequest) {
      return 'Connection Request';
    } else if (notificationType == NotificationType.application) {
      return 'Application';
    } else if (notificationType == NotificationType.takeRequestConfirmation) {
      return 'Take Request Confirmation';
    } else if (notificationType == NotificationType.userCompletedJob) {
      return 'User Completed Job';
    } else if (notificationType == NotificationType.jobCancellation) {
      return 'Job Cancellation';
    } else {
      return 'Dev';
    }
  }

  static NotificationStatus _stringToNotificationStatus(
      String notificationStatus) {
    if (notificationStatus == 'Unead') {
      return NotificationStatus.unread;
    } else if (notificationStatus == 'Read') {
      return NotificationStatus.read;
    } else {
      return NotificationStatus.clicked;
    }
  }

  static String _notificationStatusToString(
      NotificationStatus notificationStatus) {
    if (notificationStatus == NotificationStatus.unread) {
      return 'Unread';
    } else if (notificationStatus == NotificationStatus.read) {
      return 'Read';
    } else {
      return 'Clicked';
    }
  }
}
