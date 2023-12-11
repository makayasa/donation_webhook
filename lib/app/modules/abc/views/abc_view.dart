import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:get_server/get_server.dart';

import '../controllers/abc_controller.dart';

class AbcView extends GetView<AbcController> {
  const AbcView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
