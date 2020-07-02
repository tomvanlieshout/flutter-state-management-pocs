import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './counter_bloc.dart';
import 'counter_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BloC demonstration',
      // Here, we wrap the CounterPage in a BlocProvider that serves the CounterBloc, giving the 
      // CounterPage access to CounterEvent.increment and CounterEvent.decrement, as well as the 
      // count data.
      home: BlocProvider<CounterBloc>(
        create: (context) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}