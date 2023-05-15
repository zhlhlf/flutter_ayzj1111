import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_constant.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/novel/rank_model.dart';
import 'package:flutter_dmzj/modules/novel/home/rank/novel_rank_controller.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_dmzj/widgets/keep_alive_wrapper.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/page_list_view.dart';
import 'package:get/get.dart';

class NovelRankView extends StatelessWidget {
  final NovelRankController controller;
  NovelRankView({Key? key})
      : controller = Get.put(NovelRankController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                buildFilter(
                  // ignore: invalid_use_of_protected_member
                  types: controller.tags.value,
                  value: controller.tag.value,
                  onSelected: (e) {
                    controller.tag.value = e;
                    controller.refreshData();
                  },
                ),
                buildFilter(
                  types: controller.rankTypes,
                  value: controller.rankType.value,
                  onSelected: (e) {
                    controller.rankType.value = e;
                    controller.refreshData();
                  },
                ),
              ],
            ),
          ),
          AppStyle.vGap12,
          Expanded(
            child: PageListView(
              pageController: controller,
              firstRefresh: true,
              showPageLoadding: false,
              separatorBuilder: (context, i) => Divider(
                endIndent: 12,
                indent: 12,
                color: Colors.grey.withOpacity(.2),
                height: 1,
              ),
              itemBuilder: (context, i) {
                var item = controller.list[i];
                return buildItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilter({
    required Map<int, String> types,
    required int value,
    required Function(int) onSelected,
  }) {
    return Expanded(
      child: PopupMenuButton<int>(
        onSelected: onSelected,
        itemBuilder: (c) => types.keys
            .map(
              (k) => CheckedPopupMenuItem<int>(
                value: k,
                checked: k == value,
                child: Text(types[k] ?? ""),
              ),
            )
            .toList(),
        child: SizedBox(
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                types[value] ?? "",
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem(NovelRankModel item) {
    return InkWell(
      onTap: () {
        AppNavigator.toNovelDetail(item.id);
      },
      child: Container(
        padding: AppStyle.edgeInsetsA12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NetImage(
              item.cover,
              width: 80,
              height: 110,
              borderRadius: 4,
            ),
            AppStyle.hGap12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text.rich(
                    TextSpan(children: [
                      const WidgetSpan(
                          child: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                        size: 18,
                      )),
                      const TextSpan(
                        text: " ",
                      ),
                      TextSpan(
                          text: item.authors,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ),
                  const SizedBox(height: 2),
                  Text(item.types.join("/"),
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(item.lastUpdateChapterName,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text("更新于${Utils.formatTimestamp(item.lastUpdateTime)}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            Center(
              child: Obx(
                () => UserService.instance.subscribedNovelIds.contains(item.id)
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          UserService.instance.cancelSubscribe(
                            [item.id],
                            AppConstant.kTypeNovel,
                          );
                        },
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          UserService.instance.addSubscribe(
                            [item.id],
                            AppConstant.kTypeNovel,
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
