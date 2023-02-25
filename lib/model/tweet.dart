class Tweet {
  String? id;
  String? tweetText;

  Tweet({
    required this.id,
    required this.tweetText,
  });

  static List<Tweet> tweetList() {
    return [
      Tweet(id: '02', tweetText: 'I am Elon Musk', ),
      Tweet(id: '01', tweetText: 'Gonna buy twitt3r',),
      Tweet(
        id: '03',
        tweetText: 'Lewis Hamilton speaking facts as always \n #F1',
      ),
      Tweet(
        id: '04',
        tweetText: 'A new era, but the same old banter',
      ),
    ];
  }
}
