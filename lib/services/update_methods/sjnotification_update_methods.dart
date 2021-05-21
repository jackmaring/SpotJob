import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotjob/models/chat.dart';
import 'package:spotjob/models/job.dart';

import 'package:spotjob/models/sj_notification.dart';
import 'package:spotjob/models/user.dart';
import 'package:spotjob/services/crud_models/sjnotification_crud_model.dart';
import 'package:spotjob/utils/useful_methods.dart';

class SJNotificationUpdateMethods {
  static void createMessageNotification({User senderUser, User acceptorUser, Message message}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: acceptorUser.id,
        senderId: senderUser.id,
        notificationType: NotificationType.message,
        notificationStatus: NotificationStatus.unread,
        title: '${senderUser.name} sent you a message',
        content: UsefulMethods.truncateWithEllipsis(20, message.content),
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static void createApplicationNotification({User posterUser, User takerUser, Job job}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: posterUser.id,
        senderId: takerUser.id,
        notificationType: NotificationType.application,
        notificationStatus: NotificationStatus.unread,
        title: 'Application recieved',
        content: '${takerUser.name} applied for your job: ${job.title}',
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static void createTakeRequestConfirmationNotification({User posterUser, User takerUser, Job job}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: takerUser.id,
        senderId: posterUser.id,
        notificationType: NotificationType.takeRequestConfirmation,
        notificationStatus: NotificationStatus.unread,
        title: 'Take request accepted',
        content: '${posterUser.name} accepted your take request for: ${job.title}',
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static void createPosterUserCompletedJobNotification(
      {User posterUser, User takerUser, Job job}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: takerUser.id,
        senderId: posterUser.id,
        notificationType: NotificationType.userCompletedJob,
        notificationStatus: NotificationStatus.unread,
        title: 'Job finished',
        content: '${posterUser.name} finished the job: ${job.title}',
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static void createTakerUserCompletedJobNotification(
      {User posterUser, User takerUser, Job job}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: posterUser.id,
        senderId: takerUser.id,
        notificationType: NotificationType.userCompletedJob,
        notificationStatus: NotificationStatus.unread,
        title: 'Job completed',
        content: '${takerUser.name} completed the job: ${job.title}',
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static void createUserCancelledJobNotification(
      {User posterUser, User takerUser, Job job}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: posterUser.id,
        senderId: takerUser.id,
        notificationType: NotificationType.jobCancellation,
        notificationStatus: NotificationStatus.unread,
        title: 'Job cancelled',
        content: '${takerUser.name} cancelled the job: ${job.title}',
        dateCreated: Timestamp.now(),
      ),
    );
  }

  static void createConnectionRequestNotification(
      {User senderUser, User acceptorUser}) {
    SJNotificationCRUD sjnotificationCrud = SJNotificationCRUD();
    sjnotificationCrud.addSJNotification(
      SJNotification(
        receiverId: acceptorUser.id,
        senderId: senderUser.id,
        notificationType: NotificationType.connectionRequest,
        notificationStatus: NotificationStatus.unread,
        title: 'Connection request',
        content: '${senderUser.name} sent you a friend request',
        dateCreated: Timestamp.now(),
      ),
    );
  }
}
