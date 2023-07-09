import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption/repo/pet/pet_repo.dart';
import 'package:pet_adoption/repo/pet/pret_app_repo.dart';

// AppRepositoryWidget injects the Repos that are required during the initialization
// of the app.
class AppRepositoryWidget extends StatelessWidget {
  final Widget child;
  const AppRepositoryWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<PetRepo>(create: (context) => PetAppRepo(), lazy: true)
    ], child: child);
  }
}
