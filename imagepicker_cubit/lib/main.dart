import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagepicker_cubit/cubit/image_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider<ImageCubit>(
          create: (context) => ImageCubit(),
          child: const MyHomePage(title: 'Image Picker'),
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: BlocBuilder<ImageCubit, ImageState>(
        builder: (context, state) {
          if (state is ImageInitialState) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<ImageCubit>().pickImage();
                },
                child: const Text("Pick image"),
              ),
            );
          } else if (state is ImageErrorState) {
            return Center(
              child: Column(
                children: [
                  Text(state.message),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ImageCubit>().pickImage();
                    },
                    child: const Text("Try again!"),
                  ),
                ],
              ),
            );
          } else if (state is ImageLoadedState) {
            return Center(
              child: Column(
                children: [
                  Image.file(
                    File(state.imagePath),
                    width: 350,
                    height: 350,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ImageCubit>().pickImage();
                    },
                    child: const Text("Pick another image"),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
