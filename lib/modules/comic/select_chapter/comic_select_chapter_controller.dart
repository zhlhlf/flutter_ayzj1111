import 'package:flutter_dmzj/app/controller/base_controller.dart';
import 'package:flutter_dmzj/models/comic/detail_info.dart';
import 'package:flutter_dmzj/requests/comic_request.dart';
import 'package:flutter_dmzj/routes/app_navigator.dart';
import 'package:flutter_dmzj/services/comic_download_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class ComicSelectChapterController extends BaseController {
  final int comicId;
  ComicSelectChapterController(this.comicId);
  final ComicRequest request = ComicRequest();

  RxList<ComicDetailVolume> volumes = RxList<ComicDetailVolume>();

  RxSet<int> chapterIds = RxSet<int>();

  String comicTitle = "";
  String comicCover = "";
  bool islong = false;

  @override
  void onInit() {
    loadDetail();

    super.onInit();
  }

  void refreshV1() async {
    try {
      var result =
          await request.comicDetail(comicId: comicId, priorityV1: true);
      if (result.volumes.isEmpty) {
        SmartDialog.showToast("没有找到任何章节");
        return;
      }
      comicTitle = result.title;
      comicCover = result.cover;
      islong = result.isLong;
      for (var volume in result.volumes) {
        volume.sortType.value = 1;
        volume.sort();
      }
      volumes.value = result.volumes;
    } catch (e) {
      SmartDialog.showToast("无法获取章节");
    }
  }

  /// 加载信息
  void loadDetail() async {
    try {
      pageLoadding.value = true;
      pageError.value = false;
      var result = await request.comicDetail(comicId: comicId);
      comicTitle = result.title;
      comicCover = result.cover;
      islong = result.isLong;
      if (result.volumes.isEmpty && !result.isHide) {
        refreshV1();
      } else {
        for (var volume in result.volumes) {
          volume.sortType.value = 1;
          volume.sort();
        }
        volumes.value = result.volumes;
      }
    } catch (e) {
      pageError.value = true;
      errorMsg.value = e.toString();
    } finally {
      pageLoadding.value = false;
    }
  }

  void selectItem(ComicDetailChapterItem item) {
    //禁止下载VIP章节
    if (item.isVip) {
      SmartDialog.showToast("请使用动漫之家官方APP下载VIP章节");
      return;
    }
    if (chapterIds.contains(item.chapterId)) {
      chapterIds.remove(item.chapterId);
    } else {
      chapterIds.add(item.chapterId);
    }
  }

  void selectAll() {
    for (var volume in volumes) {
      for (var chapter in volume.chapters) {
        if (chapter.isVip) {
          continue;
        }
        var id = "${comicId}_${chapter.chapterId}";
        if (!ComicDownloadService.instance.downloadIds.contains(id)) {
          chapterIds.add(chapter.chapterId);
        }
      }
    }
  }

  void cleanAll() {
    chapterIds.clear();
  }

  void toDownloadManage() {
    AppNavigator.toComicDownloadManage(1);
  }

  void startDownload() {
    if (chapterIds.isEmpty) {
      SmartDialog.showToast("请选择需要下载的章节");
      return;
    }
    for (var id in chapterIds) {
      //搜索章节
      ComicDetailVolume? volume;
      ComicDetailChapterItem? chapter;
      for (var item in volumes) {
        var chapterItem =
            item.chapters.firstWhereOrNull((y) => y.chapterId == id);
        if (chapterItem != null) {
          volume = item;
          chapter = chapterItem;
          break;
        }
      }
      if (volume == null || chapter == null) {
        continue;
      }
      ComicDownloadService.instance.addTask(
        comicId: comicId,
        chapterId: chapter.chapterId,
        chapterSort: chapter.chapterOrder,
        volumeName: volume.title,
        comicTitle: comicTitle,
        comicCover: comicCover,
        chapterName: chapter.chapterTitle,
        isVip: chapter.isVip,
        isLongComic: islong,
      );
    }
    chapterIds.clear();
    SmartDialog.showToast("已添加到下载列表，下载过程中请保存APP在前台运行");
  }
}
