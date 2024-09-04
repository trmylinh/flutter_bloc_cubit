part of 'player_cubit.dart';

final List<Map<String, dynamic>> allPlayers = [
  {"name": "Linh Nguyen", "country": "Vietnam"},
  {"name": "John Smith", "country": "USA"},
  {"name": "Maria Garcia", "country": "Spain"},
  {"name": "Akira Yamada", "country": "Japan"},
  {"name": "Chen Wei", "country": "China"},
  {"name": "Emma Brown", "country": "UK"},
  {"name": "Lea Dubois", "country": "France"},
  {"name": "Pedro Oliveira", "country": "Brazil"},
  {"name": "Ananya Sharma", "country": "India"},
  {"name": "Fatima Al-Farsi", "country": "UAE"}
];

sealed class PlayerState {}

final class PlayerInitialState extends PlayerState {
  final List<Player> players;
  PlayerInitialState(this.players);
}

final class PlayerFilterState extends PlayerState {
  final List<Player> filterPlayers;
  PlayerFilterState(this.filterPlayers);
}

final class PlayerUpdatedState extends PlayerState {
  final List<Player> updatedPlayers;
  PlayerUpdatedState(this.updatedPlayers);
}
