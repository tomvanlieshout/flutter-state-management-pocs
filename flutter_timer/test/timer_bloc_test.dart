import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../lib/bloc/timer_bloc.dart';
import '../lib/bloc/timer_state.dart';
import '../lib/bloc/timer_event.dart';
import 'package:flutter_timer/ticker.dart';

class MockTicker extends Mock implements Ticker {}

void main() {
  MockTicker mockTicker;
  TimerBloc timerBloc;

  setUp(() {
    mockTicker = MockTicker();
    timerBloc = TimerBloc(ticker: mockTicker);
  });

  tearDown(() {
    timerBloc.close();
  });
  group('TimerBloc', () {

    blocTest(
      'timerBloc _mapStartToState test',
      build: () => TimerBloc(ticker: new Ticker()),
      act: (bloc) => bloc.add(Start),
      expect: [Running],
    );
  });
}
