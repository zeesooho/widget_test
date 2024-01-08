import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("게시글"),
    );
  }
}

// {
//     post: {
//         "id": 0,
//       "title": "string",
//       "content": "string",
//       "view": 0,
//       "hit": 0,
//       "createdAt": "string",
//       "updatedAt": "string",
//        "user":
//       {
//          "type": "student" or "incumbent",
//          "id" : 0,
//          "name": "string",
//          "image": "string"
//       }
//     },
//  }