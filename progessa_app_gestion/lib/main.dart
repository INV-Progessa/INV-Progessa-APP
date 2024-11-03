import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'views/login_page.dart';
import 'views/bodeguero.dart'; // Asegúrate de tener importada esta página

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routes: {
          '/': (context) => LoginPage(),
          '/bodeguero': (context) => BodegueroPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
