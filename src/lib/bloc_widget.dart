import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/fetch/pets_fetch_bloc.dart';
import 'repo/pet/pet_repo.dart';

// BlocWidget injects the Blocs that are required during the initialization
// of the app.
class BlocWidget extends StatelessWidget {
  final Widget child;
  const BlocWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PetsFetchBloc>(
        create: (context) =>
            PetsFetchBloc(petRepo: RepositoryProvider.of<PetRepo>(context)),
      ),
    ], child: child);
  }
}
