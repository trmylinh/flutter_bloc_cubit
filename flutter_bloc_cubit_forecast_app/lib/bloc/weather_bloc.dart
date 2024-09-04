import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_cubit_forecast_app/bloc/weather_event.dart';

import '../cubit/weather_state.dart';
import '../data/model/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherBloc(this._weatherRepository) : super(const WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
      WeatherEvent event,
      ) async* {
    if (event is GetWeather) {
      try {
        yield const WeatherLoading();
        final weather = await _weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkException {
        yield const WeatherError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}