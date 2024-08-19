import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NotificationPage.dart';

class NotificationICon extends StatelessWidget {
  const NotificationICon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationPage()),
          ), // Handle notification tap (replace with your navigation logic)
        ),
        // ApiSinglePageSmall(
        //   requestFunction: () => restClient.notifications
        //       .getUnseenNotificationsCountNotificationsUnseenNotificationsCountGet(),
        //   child: (c, data) {
        //     if (data!.unseenNotificationsCount! > 0) {
        //       return Positioned(
        //         // Position the counter badge more precisely
        //         top: 4.0, // Adjust top offset as needed
        //         right: 4.0, // Adjust right offset as needed
        //         child: Container(
        //           padding: const EdgeInsets.all(2.0), // Add some padding
        //           decoration: BoxDecoration(
        //             // color: Colors.red, // Customize badge color
        //             borderRadius:
        //                 BorderRadius.circular(80.0), // Rounded corners
        //           ),
        //           child: Text(
        //             data.unseenNotificationsCount.toString(),
        //             style: const TextStyle(
        //               color: Colors.white,
        //               fontSize: 12.0, // Adjust font size as needed
        //             ),
        //           ),
        //         ),
        //       );
        //     }
        //     return SizedBox();
        //   },
        //   future: (hDMHttpRequestsStates) =>
        //       HDMHttpReqFunc.Req<NotificationIConData, NotificationIConData>(
        //           fromJson: (x) => NotificationIConData.fromJson(x),
        //           Link: '${serverUrl}notifications/unseen-notifications-count',
        //           hDMHttpType: HDMHttpType.GET,
        //           hDMHttpRequestsStates: hDMHttpRequestsStates),
        // )
      ],
    );
  }
}
