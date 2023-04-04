import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:g10mart/providers/home_provider.dart';
import 'package:g10mart/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'G10Mart',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
