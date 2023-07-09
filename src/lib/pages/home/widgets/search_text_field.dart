import 'package:flutter/material.dart';

// A textfield used in searching of the pets based on the pet names
class SearchTextfield extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchTextfield({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: 'Search pet to adopt',
        prefixIcon: Icon(
          Icons.search_outlined,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
