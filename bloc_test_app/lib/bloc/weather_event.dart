import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchedWeather extends WeatherEvent {
  final String cityName;

  const FetchedWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class FetchedDetailedWeather extends WeatherEvent {
  final String cityName;

  const FetchedDetailedWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}
