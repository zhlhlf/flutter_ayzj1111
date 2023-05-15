import 'package:video_cached_player/video_cached_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/vide-info.dart';
import './vide-oprations.dart';

class playvide extends StatefulWidget {
  final String title = "sdf";
  final String url;
  const playvide(this.url, {super.key});

  @override
  State<playvide> createState() => playvide1();
}

// ignore: camel_case_types
class playvide1 extends State<playvide> {
  late CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
        });
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(height: double.infinity, child: CachedVideoPlayer(_controller)),
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: TextButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: const Text(""),
        ),
      ),
              Positioned(
            bottom: 20,
            left: 10,
            child: VideoInfo(
              author: '港漂的小石头',
              title: '在香港找一个地道内地口味的烧烤有多难，他们家吃过一次就真的爱上了',
              tags: const [
                '香港美食',
                '香港烧烤',
                '香港旅游攻略',
                '跟着抖音来探店',
                '考验官',
              ],
            )),
                    Positioned(
          child: VideoOprations(),
          right: 10,
          bottom: 20,
        )
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class videpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(scrollDirection: Axis.vertical, children: const [
      playvide(
          "https://watery-quill-felidae.glitch.me/%E4%B8%B4%E6%97%B6%E5%AD%98%E6%94%BE%E6%96%87%E4%BB%B6/vides-test/vide_14.mp4"),
      playvide(
         "https://watery-quill-felidae.glitch.me/%E4%B8%B4%E6%97%B6%E5%AD%98%E6%94%BE%E6%96%87%E4%BB%B6/vides-test/vide_12.mp4"),
      playvide(
          "https://watery-quill-felidae.glitch.me/%E4%B8%B4%E6%97%B6%E5%AD%98%E6%94%BE%E6%96%87%E4%BB%B6/vides-test/vide_5.mp4"),
      playvide(
          "https://watery-quill-felidae.glitch.me/%E4%B8%B4%E6%97%B6%E5%AD%98%E6%94%BE%E6%96%87%E4%BB%B6/vides-test/vide_16.mp4"),
      playvide(
          "https://watery-quill-felidae.glitch.me/%E4%B8%B4%E6%97%B6%E5%AD%98%E6%94%BE%E6%96%87%E4%BB%B6/vides-test/vide_17.mp4"),
      playvide(
          "https://watery-quill-felidae.glitch.me/%E4%B8%B4%E6%97%B6%E5%AD%98%E6%94%BE%E6%96%87%E4%BB%B6/vides-test/vide_19.mp4")
        
    ]);
  }
}

/* class videpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: urlsd.length,
        itemBuilder: ((context, index) {
          return playvide("${urlsd[index]}");
        }));
  }
} */

