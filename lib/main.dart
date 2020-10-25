import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickAndMorty/app/provider/characters_provider.dart';

import 'app/view/bottom_navigation_bar/page/bottom_navigation_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // ignore: always_specify_types
      providers: [
        ChangeNotifierProvider<CharactersProvider>(
            create: (BuildContext context) => CharactersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: BottomNavigationBarWidget(),
      ),
    );
  }
}
