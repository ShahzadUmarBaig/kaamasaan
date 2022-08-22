import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaamasaan/applications/home_bloc/home_bloc.dart';
import 'package:kaamasaan/route_generator.dart';
import 'package:kaamasaan/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: MaterialApp(
        title: 'KaamAsaan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
