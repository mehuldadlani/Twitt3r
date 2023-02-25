import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../model/tweet.dart';

class Tweet_tile extends StatelessWidget {
  final Tweet tweet;
  final onTweetChanged;
  final onDeleteTweet;
  bool isLiked = false;
  int likeCount = 17;

  Tweet_tile(
      {Key? key, required this.tweet, this.onTweetChanged, this.onDeleteTweet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ListTile(
        minVerticalPadding: 30,
        onTap: () {
          onTweetChanged(tweet);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.asset(
            'assets/avatar.png',
            height: 50.0,
            width: 50.0,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          tweet.tweetText!,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        trailing: PopupMenuButton<int>(
          color: Colors.white,
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    LikeButton(
                      size: 25,
                      isLiked: isLiked,
                      likeCount: likeCount,
                    )
                  ],
                )),
            PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                      Icons.mode_comment_outlined,
                      color: Colors.black,
                    ),
                     SizedBox(
                      width: 7,
                    ),
                    Text("Comment")
                  ],
                )),
            PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.repeat,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text("Retweet")
                  ],
                )),
            PopupMenuDivider(),
            PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text("Delete")
                  ],
                )),
          ],
          onSelected: (item) => SelectedItem(context, item),
        ),
      ),
    );
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        print("Tweet Liked");
        break;
      case 1:
        print("Comment Clicked");
        break;
      case 2:
        print("Retweeted");
        break;
      case 3:
        onDeleteTweet(tweet.id);
        break;
    }
  }
}
