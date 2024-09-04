import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_bloc_cubit_forecast_app/bloc/weather_event.dart';
import 'package:flutter_bloc_cubit_forecast_app/cubit/weather_cubit.dart';
import 'package:flutter_bloc_cubit_forecast_app/cubit/weather_state.dart';
import 'package:flutter_bloc_cubit_forecast_app/data/model/weather.dart';
class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({super.key});

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        // TODO: Implement with cubit
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state){
            if(state is WeatherInitial){
              return buildInitialInput();
            } else if (state is WeatherLoading){
              return buildLoading();
            } else if (state is WeatherLoaded){
              return buildColumnWithData(state.weather);
            } else {
              // state is WeatherError
              return buildInitialInput();
            }
          },
        )
      ),
    );
  }

  Widget buildInitialInput(){
    return const Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          "${weather.temperatureCelsius.toStringAsFixed(1)} °C",
          style: const TextStyle(fontSize: 80),
        ),
        const CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search)
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName){
    // final weatherCubit = context.read<WeatherCubit>();
    // weatherCubit.getWeather(cityName);
    final weatherBloc = context.read<WeatherBloc>();
    weatherBloc.add(GetWeather(cityName));
  }
}

