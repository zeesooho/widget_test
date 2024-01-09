import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_test/common/colors.dart';
import 'package:widget_test/post/post_data.dart';
import 'package:widget_test/post/post_list.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("게시판"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CupertinoButton(child: const Text("글 작성", style: TextStyle(color: CupertinoColors.activeBlue)), onPressed: () {}),
            // child: ElevatedButton.icon(
            //   style: const ButtonStyle(
            //     backgroundColor: MaterialStatePropertyAll(defaultColor),
            //   ),
            //   onPressed: () {},`
            //   icon: const Icon(CupertinoIcons.right_chevron, color: Colors.white),
            //   label: const Text("글 작성", style: TextStyle(color: Colors.white)),
            // ),
          )
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: FutureBuilder(
        future: http.get(
          Uri.parse(""),
          headers: {'Content-type': 'application/json; UTF-8'},
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var response = snapshot.data!;
            var postDatas = <PostData>[];
            if (response.statusCode == 200) {
              var body = json.decode(response.body);
              postDatas = body['data'].map<PostData>((post) => PostData.fromJson(post)).toList();
            } else {
              postDatas = [];
            }

            return PostList(
              postDatas: postDatas,
              scrollController: ScrollController(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
