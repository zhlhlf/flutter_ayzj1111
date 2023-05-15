import './fonts/iconfont.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class _VideoOprationIcon extends StatelessWidget {
  late int number;

  late IconData icon;

  _VideoOprationIcon({super.key, required this.number, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(children: [
        Icon(icon, color: Colors.white),
        Text(
          number.toString(),
          style: TextStyle(color: Colors.white, fontSize: 13),
        )
      ]),
    );
  }
}

class _VideoOprationAvatar extends StatelessWidget {
  const _VideoOprationAvatar({super.key});

  final double avatarSize = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
                child: PhysicalModel(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                    child: Image.network(
                      'http://q1.qlogo.cn/g?b=qq&nk=2915513255&s=40',
                      width: avatarSize - 2,
                      height: avatarSize - 2,
                    ))),
          ),
          Positioned(
              child: Icon(
                IconfontIcon.add,
                color: Colors.pink,
                size: 16,
              ),
              bottom: -2,
              left: (40 - 14) / 2)
        ],
      ),
    );
  }
}

class VideoOprations extends StatelessWidget {
  const VideoOprations({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        _VideoOprationAvatar(),
        _VideoOprationIcon(
          number: 3188,
          icon: IconfontIcon.heart,
        ),
        _VideoOprationIcon(
          number: 3188,
          icon: IconfontIcon.comment,
        ),
        _VideoOprationIcon(
          number: 3188,
          icon: IconfontIcon.star,
        ),
        _VideoOprationIcon(
          number: 3188,
          icon: IconfontIcon.share,
        )
      ]),
    );
  }
}
