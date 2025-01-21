import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'views/login_view.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/book_viewmodel.dart';
import 'viewmodels/room_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()), // Auth ViewModel
        ChangeNotifierProvider(create: (_) => BookViewModel()..fetchBooks()),
        ChangeNotifierProvider(create: (context) => RoomViewModel()), // Book ViewModel
      ],
      child: MaterialApp(
        title: 'MVVM Firebase App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  LoginView(),
      ),
    );
  }
}
