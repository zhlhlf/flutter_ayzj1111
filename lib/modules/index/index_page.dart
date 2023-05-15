import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/common/empty_page.dart';
import 'package:flutter_dmzj/modules/index/index_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = _buildContentNavigator();
    final indexStack = _buildIndexStack();
    return _buildNarrow(context, indexStack, content);
  }

  Widget _buildNarrow(BuildContext context, Widget indexStack, Widget content) {
    return Stack(
      children: [
        Obx(
          () => Scaffold(
            body: indexStack,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: controller.setIndex,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
                      items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_call,
              color: Color.fromARGB(255, 152, 239, 230),
            ),
            label: "爱音",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
              color: Color.fromARGB(255, 152, 239, 230),
            ),
            label: "服务",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
              color: Color.fromARGB(255, 152, 239, 230),
            ),
            label: "我要发表",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.android,
              color: Color.fromARGB(255, 152, 239, 230),
            ),
            label: "我的",
          ),
        ],
            ),
          ),
        ),
        Obx(
          () => IgnorePointer(
            ignoring: !controller.showContent.value,
            child: content,
          ),
        )
      ],
    );
  }


  Widget _buildIndexStack() {
    return Obx(
      () => IndexedStack(
        key: controller.indexKey,
        index: controller.index.value,
        children: controller.pages,
      ),
    );
  }

  /// 子路由
  Widget _buildContentNavigator() {
    /// 拦截子路由的返回
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.canPop(Get.context!)) {
          return true;
        }
        if (AppNavigator.subNavigatorKey!.currentState!.canPop()) {
          AppNavigator.subNavigatorKey!.currentState!.pop();
          return false;
        }
        return true;
      },
      child: ClipRect(
        child: Navigator(
          key: AppNavigator.subNavigatorKey,
          initialRoute: '/',
          onUnknownRoute: (settings) => GetPageRoute(
            page: () => const EmptyPage(),
          ),
          observers: [
            SubNavigatorObserver(),
          ],
          onGenerateRoute: AppPages.generateSubRoute,
        ),
      ),
    );
  }
}

/// 子路由监听
class SubNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      var routeName = route.settings.name ?? "";
      AppNavigator.currentContentRouteName = routeName;
      Get.find<IndexController>().showContent.value = routeName != '/';
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);

    var routeName = previousRoute?.settings.name ?? "";
    AppNavigator.currentContentRouteName = routeName;
    Get.find<IndexController>().showContent.value = routeName != '/';
  }
}
