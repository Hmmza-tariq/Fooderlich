import 'package:flutter/material.dart';

import '../models/models.dart';

class FriendPostTile extends StatelessWidget {
  const FriendPostTile({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              post.foodPictureUrl,
              width: 400.0,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 8.0,
            left: 8.0,
            child: CircleAvatar(
              backgroundImage: AssetImage(post.profileImageUrl),
              radius: 40.0,
            ),
          ),
          Positioned(
            top: 38.0,
            left: 100.0,
            child: Text(
              post.comment,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            child: Text(
              '${post.timestamp} minutes ago',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
