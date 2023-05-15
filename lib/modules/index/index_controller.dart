import 'package:flutter/material.dart';
import 'package:flutter_dmzj/services/app_settings_service.dart';
import 'package:flutter_dmzj/app/dialog_utils.dart';
import 'package:flutter_dmzj/app/event_bus.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_page.dart';
import 'package:flutter_dmzj/modules/news/home/news_home_controller.dart';
import 'package:flutter_dmzj/modules/news/home/news_home_page.dart';
import 'package:flutter_dmzj/modules/novel/home/novel_home_controller.dart';
import 'package:flutter_dmzj/modules/novel/home/novel_home_page.dart';
import 'package:flutter_dmzj/modules/user/user_home_page.dart';
import 'package:get/get.dart';
import 'package:multi_split_view/multi_split_view.dart';

import '../../widgets/tab_appbar.dart';


class IndexController extends GetxController {
  final index = 0.obs;
  final showContent = false.obs;
  final GlobalKey indexKey = GlobalKey();
  final GlobalKey subRouterKey = GlobalKey();

  final MultiSplitViewController multiSplitViewController =
      MultiSplitViewController(areas: [
    Area(minimalSize: 400, size: 500),
  ]);
  final pages = [
    const ComicHomePage(),
    fw(),
    const Center(child: Text("论坛暂未开放"),),
    const UserHomePage(),
  ];
  @override
  void onInit() {
    Future.delayed(Duration.zero, showFirstRun);
    super.onInit();
  }

  @override
  void onClose() {}

  void setIndex(i) {
    if (i == 1 && pages[i] is SizedBox) {
      Get.put(NewsHomeController());
      pages[i] = const NewsHomePage();
    } else if (i == 2 && pages[i] is SizedBox) {
      Get.put(NovelHomeController());
      pages[i] = const NovelHomePage();
    }
    if (index.value == i) {
      EventBus.instance.emit<int>(EventBus.kBottomNavigationBarClicked, i);
    }
    index.value = i;
  }

  void showFirstRun() async {
    if (AppSettingsService.instance.firstRun) {
      AppSettingsService.instance.setNoFirstRun();
      DialogUtils.showStatement();
      Utils.checkUpdate();
    } else {
      Utils.checkUpdate();
    }
  }
}




class fw extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => fw1();
}

class fw1 extends State<fw> with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
          appBar:  TabAppBar(
        controller: tabController,
        tabs: const [
          Tab(text: "服务"),
          Tab(text: "集采"),
        ],),

      body: TabBarView(
        controller: tabController,
        children:  const [
         Center(child:  Text("服务界面待开发")),   
         Center(child: Text("集采界面待开发")),
        ]
    ));
  }
}
