import 'package:flutter/material.dart';
import 'package:widget_test/post/post_data.dart';
import 'package:widget_test/post/post_list.dart';

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
      ),
      body: PostList(
        postDatas: [
          PostData(
            id: 1,
            title: '제목1',
            content: '글내용',
            view: 1,
            hit: 1,
            createdAt: "2024-01-08",
            updatedAt: "2024-01-08",
            user: PostUserData(type: "incumbent", id: 1, name: "현직자1"),
          ),
          PostData(
            id: 2,
            title: '제목2',
            content: '글내용이 점점점 길어진다면??? 이건 어디서부터 ... 처리를 할지 고민 좀 해봐야할 듯',
            view: 11,
            hit: 1,
            createdAt: "2024-01-08",
            updatedAt: "2024-01-08",
            user: PostUserData(type: "incumbent", id: 2, name: "현직자2"),
          ),
          PostData(
            id: 3,
            title: '제목3',
            content: '글내용이 점점점 길어진다면??? \n 이건 어디서부터 ... 처리를 할지 고민 좀 해봐야할 듯',
            view: 10,
            hit: 1,
            createdAt: "2024-01-08",
            updatedAt: "2024-01-09",
            user: PostUserData(type: "student", id: 3, name: "학생1"),
          ),
        ],
      ),
    );
  }
}
