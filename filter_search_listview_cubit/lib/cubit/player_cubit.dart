import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(PlayerInitialState(allPlayers));

  void filterPlayer(String name) {
    if (name.isEmpty) {
      emit(PlayerInitialState(allPlayers));
    } else {
      final filteredList = allPlayers
          .where((player) => player['name']
              .toString()
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
      emit(PlayerFilterState(filteredList));
    }
  }
}
