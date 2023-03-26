import 'package:flutter/material.dart';
import 'package:free_games/providers/games_provider.dart';
import 'package:provider/provider.dart';

class DetailedGameScreen extends StatefulWidget {
  const DetailedGameScreen(
      {super.key, required this.gameId, required this.isPcGame});
  final int gameId;
  final bool isPcGame;
  @override
  State<DetailedGameScreen> createState() => _DetailedGameScreenState();
}

class _DetailedGameScreenState extends State<DetailedGameScreen> {
  @override
  void initState() {
    Provider.of<GamesProvider>(context, listen: false)
        .getSingleGame(widget.gameId, widget.isPcGame);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProvider>(builder: (context, gamesC0nsumer, child) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        body: Center(
          child: gamesC0nsumer.isLoading
              ? const CircularProgressIndicator()
              : widget.isPcGame
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              gamesC0nsumer.pcGameModel!.thumbnail,
                              width: size.width,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                                right: 0,
                                top: 0,
                                left: 0,
                                child: SafeArea(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.arrow_back_ios),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        Text(
                            "${gamesC0nsumer.pcGameModel!.title.toString()} ${widget.gameId}"),
                      ],
                    )
                  : Column(
                      children: [
                        Text(
                            "${gamesC0nsumer.webGameModel!.title.toString()} ${widget.gameId}"),
                      ],
                    ),
        ),
      );
    });
  }
}
