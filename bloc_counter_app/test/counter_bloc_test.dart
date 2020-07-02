import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import '../lib/counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    CounterBloc counterBloc;

    setUp(() {
      counterBloc = CounterBloc();
    });

    // regular test
    test('initial state is 0', () {
      expect(counterBloc.initialState, 0);
    });

    // test featuring bloc
    blocTest(
      'emits [0, 1] when CounterEvent.increment is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterEvent.increment),
      expect: [0, 1],
    );

    blocTest(
      'emits [0, -1] when CounterEvent.decrement is added',
      build: () => counterBloc,
      act: (bloc) => bloc.add(CounterEvent.decrement),
      expect: [0, -1],
    );
  });
}