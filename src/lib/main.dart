import 'package:flutter/material.dart';
import 'package:pet_adoption/app_repository_widget.dart';
import 'package:pet_adoption/app_theme.dart';
import 'package:pet_adoption/bloc_widget.dart';
import 'package:pet_adoption/pages/home/home_page.dart';
import 'package:provider/provider.dart';

import 'provider/theme_notifier.dart';

void main() {
  runApp(const PetAdoApp());
}

class PetAdoApp extends StatelessWidget {
  const PetAdoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppRepositoryWidget(
      child: BlocWidget(
        child: ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
          child: Consumer<ThemeNotifier>(
            builder: (context, notifier, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'PetAdo',
              theme:
                  notifier.darkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
              home: const HomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
