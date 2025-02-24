import 'package:flutter/material.dart';

import '../models/models.dart';
import 'components.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({super.key, required this.friendPosts});
  final List<Post> friendPosts;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16.0,
        left: 16.0,
      ),
      alignment: Alignment.center,
      color: Colors.transparent,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: friendPosts.length,
        primary: true,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return SizedBox(width: 16.0);
        },
        itemBuilder: (context, index) {
          final post = friendPosts[index];
          return FriendPostTile(post: post);
        },
      ),
    );
  }
}
