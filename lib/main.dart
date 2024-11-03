import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/tool_list_screen.dart';
import 'firebase_options.dart'; // Crie um arquivo separado para armazenar suas FirebaseOptions

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inclua as opções para web aqui
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Ferramentas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ToolListScreen(),
    );
  }
}
