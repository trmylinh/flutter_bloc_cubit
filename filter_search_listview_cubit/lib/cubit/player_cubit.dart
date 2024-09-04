import 'package:bloc/bloc.dart';
import 'package:filter_search_listview_cubit/player.dart';
import 'package:flutter/material.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  List<Player> players = [];
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController countryEditingController = TextEditingController();
  PlayerCubit() : super(PlayerInitialState([]));

  void filterPlayer(String name) {
    if (name.isEmpty) {
      emit(PlayerInitialState(players));
    } else {
      final filteredList = allPlayers
          .where((player) => player['name']
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
      emit(PlayerFilterState([]));
    }
  }

  void addPlayer(String name, String country) {
    if (name.isEmpty && country.isEmpty) {
      emit(PlayerInitialState([]));
    } else {
      players.add(Player(name, country));
      emit(PlayerUpdatedState(players));
      nameEditingController.clear();
      countryEditingController.clear();
    }
  }

  void removePlayer(int index) {
    players.removeAt(index);
    if (players.isEmpty) {
      emit(PlayerInitialState([]));
    } else {
      emit(PlayerUpdatedState(players));
    }
  }

  void dispose() {
    nameEditingController.dispose();
    countryEditingController.dispose();
  }
}
