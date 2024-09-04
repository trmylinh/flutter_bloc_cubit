import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_bloc_cubit_forecast_app/cubit/weather_cubit.dart';
import 'package:flutter_bloc_cubit_forecast_app/data/model/weather_repository.dart';
import 'package:flutter_bloc_cubit_forecast_app/pages/weather_search_page.dart';

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
      title: "Material App",
      home:BlocProvider(
          create: (context) => WeatherBloc(FakeWeatherRepository()
              // WeatherCubit(FakeWeatherRepository()
              ),
        child: const WeatherSearchPage(),
      ),
    );
  }
}

