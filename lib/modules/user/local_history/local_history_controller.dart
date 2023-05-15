import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LocalHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final int type;
  LocalHistoryController(this.type);
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this, initialIndex: type);

    super.onInit();
  }
}
