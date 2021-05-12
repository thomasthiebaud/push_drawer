import 'package:flutter/material.dart';
import 'package:push_drawer/push_drawer.dart';

final drawerKey = GlobalKey<PushDrawerState>();

class MyDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class ContentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

void main() {
  runApp(
    PushDrawer(
      key: drawerKey,
      drawerRatio: 0.9,
      drawer: MyDrawerView(),
      child: ContentView(),
    ),
  );
}
