import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_tutorial/bloc/bloc.dart';
import 'package:bloc_test_tutorial/data/model/weather.dart';
import 'package:bloc_test_tutorial/data/weather_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  group('FetchedWeather', () {
    final weather = Weather(cityName: 'London', temperatureCelsius: 7);

    test('OLD WAY emits [WeatherLoading, WeatherLoaded] when successful', () {
      when(mockWeatherRepository.fetchWeather(any))
          .thenAnswer((_) async => weather);

      final bloc = WeatherBloc(mockWeatherRepository);

      bloc.add(FetchedWeather('London'));

      expectLater(
        bloc,
        emitsInOrder([
          WeatherInitial(),
          WeatherLoadInProgress(),
          WeatherLoadSuccess(weather),
        ]),
      );
    });

    test(
        'NEWER WAY BUT LONG-WINDED emits [WeatherLoading, WeatherLoaded] when successful',
        () {
      when(mockWeatherRepository.fetchWeather(any))
          .thenAnswer((_) async => weather);

      final bloc = WeatherBloc(mockWeatherRepository);

      bloc.add(FetchedWeather('London'));

      emitsExactly(bloc, [
        WeatherInitial(),
        WeatherLoadInProgress(),
        WeatherLoadSuccess(weather),
      ]);
    });
    
    group('blocTests', () {
      blocTest(
        'emits [WeatherLoading, WeatherLoaded] when successful',
        build: () {
          when(mockWeatherRepository.fetchWeather(any))
              .thenAnswer((_) async => weather);
          return WeatherBloc(mockWeatherRepository);
        },
        act: (bloc) => bloc.add(FetchedWeather('London')),
        expect: [
          WeatherInitial(),
          WeatherLoadInProgress(),
          WeatherLoadSuccess(weather),
        ],
      );

      blocTest(
        'emits [WeatherLoading, WeatherError] when unsuccessful',
        build: () {
          when(mockWeatherRepository.fetchWeather(any))
              .thenThrow(NetworkError());
          return WeatherBloc(mockWeatherRepository);
        },
        act: (bloc) => bloc.add(FetchedWeather('London')),
        expect: [
          WeatherInitial(),
          WeatherLoadInProgress(),
          WeatherError("Couldn't fetch weather. Is the device online?"),
        ],
      );
    });
  });
}
