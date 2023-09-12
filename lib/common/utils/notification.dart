import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deliverly_app/models/date_and_time.dart';
import 'package:flutter/material.dart';

class NotificationService {
  void initialize() async {
   AwesomeNotifications().requestPermissionToSendNotifications();
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'basic notification',
        defaultColor: Colors.green,
        importance: NotificationImportance.High,
        channelDescription: 'Description',
        channelShowBadge: true,
      )
    ]);
  }

  Future<void> createNotification({
    required int id,
    required String title,
    required String body,
    //required DateAndTime dateAndTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
      ),
      // schedule: NotificationCalendar(
      //   year: dateAndTime.year,
      //   month: dateAndTime.month,
      //   day: dateAndTime.day,
      //   hour: dateAndTime.hour,
      //   minute: dateAndTime.minute,
      //   second: 0,
      //   millisecond: 0,
      // ),
    );
  }
}

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction, BuildContext context) async {
    if (receivedAction.buttonKeyPressed == 'key_next') {
      final int? id = receivedAction.id;
    }
  }
}
