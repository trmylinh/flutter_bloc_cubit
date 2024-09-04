import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_cubit_forecast_app/cubit/weather_state.dart';

import '../data/model/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState>{
  final WeatherRepository _weatherRepository; 
  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());
  
  Future<void> getWeather(String cityName) async{
    try{
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException{
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}