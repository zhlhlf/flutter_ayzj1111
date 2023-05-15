import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VideoInfo extends StatelessWidget {
  final String author;

  final String title;

  List<String> tags = [];

  VideoInfo(
      {super.key,
      required this.author,
      required this.title,
      required this.tags});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(
              '@$author',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          Wrap(
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7), fontSize: 15),
              ),
              ...tags.map((e) => Text(
                    '#$e',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
