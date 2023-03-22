import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free_games/models/game_model.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool sucess = false;
  String platform = 'pc';
  int currentIndex = 0;
  bool isLoading = false;
  List<GameModel> gamesList = [];
  getGames(String platform) async {
    setState(() {
      isLoading = true;
    });
    gamesList.clear();
    var response = await http.get(
        Uri.parse('http://www.freetogame.com/api/games?platform=$platform'));

    if (kDebugMode) {
      print("STATUS CODE IS :${response.statusCode}");
      print("BODY IS :${response.body}");
    }

    if (response.statusCode == 200) {
      setState(() {
        sucess = true;
        var rawData = json.decode(response.body);
        for (var i in rawData) {
          gamesList.add(GameModel.fromJson(i));
          setState(() {});
        }
      });
    } else {
      setState(() {
        sucess = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getGames(platform);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text(gamesList.length.toString()),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                getGames(platform);
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    sucess
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: gamesList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GridTile(
                                      footer: Container(
                                        color: Colors.white70,
                                        child: Column(
                                          children: [
                                            Text(gamesList[index].title),
                                            Text(gamesList[index].platform),
                                          ],
                                        ),
                                      ),
                                      child: Image.network(
                                        gamesList[index].thumbnail,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Center(
                                            child: Container(
                                                color: Colors.white,
                                                width: 60,
                                                height: 60,
                                                child: const Icon(Icons.image)),
                                          );
                                        },
                                      ));
                                },
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8)),
                          )
                        : SizedBox(
                            height: size.height * 1.01,
                            child: const Center(child: Text('FAILED'))),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentIndex == 0 ? platform = 'pc' : platform = 'browser';
            });
            getGames(platform);
          },
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.computer), label: 'PC'),
            BottomNavigationBarItem(icon: Icon(Icons.web), label: 'Browser'),
          ]),
    );
  }
}
