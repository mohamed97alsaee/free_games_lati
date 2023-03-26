import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:free_games/models/pc_game_model.dart';

import '../models/game_model.dart';
import '../models/web_game_model.dart';
import '../services/api.dart';

class GamesProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFailed = false;
  final _api = Api();

  List<GameModel> gamesList = [];

  PcGameModel? pcGameModel;
  WebGameModel? webGameModel;

  getGames(String? platformQuery) async {
    isLoading = true;
    notifyListeners();
    var response = await _api.get(
        platformQuery == null
            ? '/api/games'
            : '/api/games?platform=$platformQuery',
        {});

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      setGames(rawData);
    }
  }

  setGames(jsonData) {
    gamesList.clear();

    for (var i in jsonData) {
      gamesList.add(GameModel.fromJson(i));
    }

    isLoading = false;
    notifyListeners();
  }

  getSingleGame(int gameId, bool isPcGame) async {
    isLoading = true;
    notifyListeners();
    var response = await _api.get('/api/game?id=$gameId', {});

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);

      if (isPcGame) {
        setSinglePcGame(PcGameModel.fromJson(rawData));
      } else {
        setSingleWebGame(WebGameModel.fromJson(rawData));
      }
    }
  }

  setSinglePcGame(PcGameModel pcgame) {
    pcGameModel = pcgame;
    isLoading = false;
    notifyListeners();
  }

  setSingleWebGame(WebGameModel x) {
    webGameModel = x;
    isLoading = false;

    notifyListeners();
  }
}
