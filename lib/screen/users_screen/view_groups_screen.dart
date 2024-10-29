import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';

class ViewGroupsScreen extends StatefulWidget {
  const ViewGroupsScreen({super.key});

  @override
  State<ViewGroupsScreen> createState() => _ViewGroupsScreenState();
}

class _ViewGroupsScreenState extends State<ViewGroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
      ),
      drawer: drawerApp(context),
    );
  }
}
