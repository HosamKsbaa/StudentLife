import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'competenciesData.dart';

class ZoomableImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses Tree'),
      ),
      floatingActionButton: FAB(context),
      body: Center(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.white),
          imageProvider: AssetImage('assets/tree.jpg'),
        ),
      ),
    );
  }
}
