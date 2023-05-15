import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comic/home/comic_home_controller.dart';
import 'package:flutter_dmzj/widgets/tab_appbar.dart';
import 'package:get/get.dart';
import 'package:flutter_dmzj/vide.dart';

class ComicHomePage extends GetView<ComicHomeController> {
  const ComicHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabAppBar(
        tabs: const [
          Tab(text: "视频"),
          Tab(text: "信息"),
/*           Tab(text: "分类"),
          Tab(text: "排行"),
          Tab(text: "专题"), */
        ],
        controller: controller.tabController,
        action: IconButton(
          onPressed: controller.search,
          icon: const Icon(
            Icons.search,
          ),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children:  [
        videpage(),        
        Center(child: Text("消息界面待开发")),
/*           ComicRecommendView(),
          ComicLatestView(),
          ComicCategoryView(),
          ComicRankView(),
          ComicSpecialView(), */
        
        ],
      ),
    );
  }
}
