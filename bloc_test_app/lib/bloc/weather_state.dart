import 'package:equatable/equatable.dart';
import 'package:bloc_test_tutorial/data/model/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
  @override
  List<Object> get props => [];
}

class WeatherLoadInProgress extends WeatherState {
  const WeatherLoadInProgress();
  @override
  List<Object> get props => [];
}

class WeatherLoadSuccess extends WeatherState {
  final Weather weather;
  const WeatherLoadSuccess(this.weather);
  @override
  List<Object> get props => [weather];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
  @override
  List<Object> get props => [message];
}
