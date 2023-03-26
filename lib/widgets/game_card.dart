import 'package:flutter/material.dart';

import '../models/game_model.dart';
import '../screens/detailed_game_screen.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.gameModel});
  final GameModel gameModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedGameScreen(
                    gameId: gameModel.id,

                    isPcGame:   gameModel.platform.contains('PC')
                    || gameModel.platform.contains('Windows')

                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(gameModel.platform.contains('PC')
                      ? Icons.computer
                      : Icons.web)
                ],
              ),
            ),
            footer: Container(
              color: Colors.white70,
              child: Column(
                children: [
                  Text(gameModel.title),
                  Text(gameModel.platform),
                ],
              ),
            ),
            child: Image.network(
              gameModel.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Container(
                      color: Colors.white,
                      width: 60,
                      height: 60,
                      child: const Icon(Icons.image)),
                );
              },
            )),
      ),
    );
  }
}
