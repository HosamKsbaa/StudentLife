import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Constants.dart';

import '../api/rest_client.dart';
import '../main.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification'),
      ),
      body: Center(child: Text("No notification ", style: TextStyle(fontSize: 20))),
      // body: ApiInfiniteList<CNotification>(
      //   requestFunction: (pageNumber, pageSize) => restClient.notifications
      //       .getNotificationsNotificationsNotificationsPost(
      //     body: CPaginationParams(page: pageNumber, perPage: pageSize),
      //   ),
      //   listViewBuilder: (BuildContext context, List<CNotification> items) {
      //     return ListView.builder(
      //       itemCount: items.length,
      //       itemBuilder: (context, index) {
      //         return ListTile(
      //           leading: Icon(Icons.notifications),
      //           title: Text(items[index].title),
      //           subtitle: Text(items[index].body),
      //           trailing: items[index].seen
      //               ? Icon(Icons.check_circle, color: Colors.green)
      //               : Icon(Icons.check_circle_outline),
      //           onTap: () {
      //             // Handle notification tap
      //           },
      //         );
      //       },
      //     );
      //   },
      //   httpRequestsStates: HDMHttpRequestsStates<List<CNotification>>(),
      //   initialPageNumber: 1,
      //   pageSize: 10,
      // ),
    );
  }
}
