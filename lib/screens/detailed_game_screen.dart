import 'package:flutter/material.dart';

class DetailedGameScreen extends StatefulWidget {
  const DetailedGameScreen({super.key, required this.gameId});
  final int gameId;
  @override
  State<DetailedGameScreen> createState() => _DetailedGameScreenState();
}

class _DetailedGameScreenState extends State<DetailedGameScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("DTG"),
      ),
    );
  }
}
