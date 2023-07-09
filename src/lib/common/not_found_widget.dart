import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;
  const NotFoundWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/not_found.png', width: 128),
          const SizedBox(height: 12),
          Text(message,
              style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}
