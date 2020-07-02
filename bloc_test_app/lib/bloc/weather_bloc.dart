import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_test_tutorial/data/weather_repository.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository);

  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoadInProgress();
    if (event is FetchedWeather) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoadSuccess(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather. Is the device online?");
      }
    } else if (event is FetchedDetailedWeather) {
      try {
        final weather =
            await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoadSuccess(weather);
      } on NetworkError {
        yield WeatherError("Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
