import 'package:filter_search_listview_cubit/cubit/player_cubit.dart';
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
                  return buildPlayerList(state.players);
                } else if (state is PlayerFilterState) {
                  return buildPlayerList(state.filterPlayers);
                }
                return Container();
              },
            ))
          ],
        ),
      ),
    );
  }

  Widget buildPlayerList(List<Map<String, dynamic>> players) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(players[index]['name']),
          subtitle: Text(players[index]['country']),
        );
      },
      itemCount: players.length,
    );
  }
}
