import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/profile.dart';
import '../widgets/tweet_tile.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/NavBar.dart';
import 'package:flutter_application_1/model/tweet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tweet3",
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset('assets/logo.png'),
        ],
      ),
      nextScreen: Home(),
      splashIconSize: 300,
      duration: 1000,
      backgroundColor: Colors.black,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tweetsList = Tweet.tweetList();
  List<Tweet> _foundTweet = [];
  final _tweetController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onTabTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new ProfilePage()));
    }
  }

  @override
  void initState() {
    _foundTweet = tweetsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 39, 39),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(width: 100, child: Text('TWITT3R')),
        centerTitle: true,
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset(
              'assets/avatar.png',
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      drawer: NavBar(),
      body: Stack(
        children: [
          Container(
            child: (Column(children: [
              SizedBox(
                height: 80,
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 20,
                      ),
                      prefixIconConstraints:
                          BoxConstraints(maxHeight: 20, minWidth: 25),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 30),
                    child: Text(
                      'Tweets',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  for (Tweet tweet in _foundTweet)
                    Tweet_tile(
                      tweet: tweet,
                      onDeleteTweet: _deleteTweet,
                    ),
                ],
              ))
            ])),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: TextField(
                      controller: _tweetController,
                      decoration: InputDecoration(
                          hintText: 'Add a new Tweet',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      _addTweet(_tweetController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        minimumSize: Size(60, 60),
                        elevation: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 39, 39, 39),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Profile',
          ),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _deleteTweet(String id) {
    setState(() {
      tweetsList.removeWhere((item) => item.id == id);
    });
  }

  void _addTweet(String tweet) {
    setState(() {
      tweetsList.add(Tweet(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tweetText: tweet));
    });
    _tweetController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Tweet> results = [];
    if (enteredKeyword.isEmpty) {
      results = tweetsList;
    } else {
      results = tweetsList
          .where((item) => item.tweetText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTweet = results;
    });
  }

  Container SearchBar() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
      ),
    );
  }
}
