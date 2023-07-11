import 'package:flutter/material.dart';
import 'package:mobile/product/presentation/pages/spu_page.dart';
import 'injection_container.dart' as di;

void main() async {
  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized(); 
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MaterialApp(
        title: 'Material App',
        home: SPUPage()
      )
    );
  }
} 