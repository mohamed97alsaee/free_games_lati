import 'package:flutter/material.dart';
import 'package:free_games/models/game_model.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.gameModel,
  });
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.height / 10,
        width: size.width * 0.9,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                gameModel.thumbnail,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                // loadingBuilder: (context, child, loadingProgress) {
                //   // return loadingProgress CircularProgressIndicator();
                // },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Container(
                        color: Colors.white,
                        width: 60,
                        height: 60,
                        child: const Icon(Icons.image)),
                  );
                },
              ),
            ),
            Column(
              children: [
                Text(gameModel.title),
                Text(gameModel.platform),
              ],
            )
          ],
        ),
      ),
    );
  }
}
