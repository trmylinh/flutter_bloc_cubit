import 'package:filter_search_listview_cubit/cubit/player_cubit.dart';
import 'package:filter_search_listview_cubit/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider<PlayerCubit>(
          create: (context) => PlayerCubit(),
          child: const MyHomePage(title: 'Filter ListView Cubit'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    context.read<PlayerCubit>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: context.read<PlayerCubit>().nameEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                isDense: true,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: context.read<PlayerCubit>().countryEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter your country',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                isDense: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<PlayerCubit>().addPlayer(
                      context.read<PlayerCubit>().nameEditingController.text,
                      context.read<PlayerCubit>().countryEditingController.text,
                    );
              },
              child: const Text("Add player"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                context.read<PlayerCubit>().filterPlayer(value);
              },
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: BlocBuilder<PlayerCubit, PlayerState>(
              builder: (context, state) {
                if (state is PlayerInitialState) {
                  return buildEmptyList();
                } else if (state is PlayerFilterState) {
                  return buildPlayerList(state.filterPlayers);
                } else if (state is PlayerUpdatedState) {
                  return buildPlayerList(state.updatedPlayers);
                }
                return Container();
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget buildPlayerList(List<Player> players) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(players[index].name),
          subtitle: Text(players[index].country),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              context.read<PlayerCubit>().removePlayer(index);
            },
          ),
        );
      },
      itemCount: players.length,
      padding: EdgeInsets.zero,
    );
  }

  Widget buildEmptyList() {
    return const Center(
      child: Text("List is empty"),
    );
  }
}
