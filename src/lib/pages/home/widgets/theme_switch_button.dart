import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_notifier.dart';

// An IconButton to toggle the theme between dark and light and also
// animate the icon when theme changes.
class ThemeSwitchButton extends StatelessWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, _) => IconButton(
        onPressed: () {
          notifier.toggleTheme();
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (widget, animation) =>
              ScaleTransition(scale: animation, child: widget),
          child: notifier.darkTheme
              ? const Icon(Icons.light_mode, key: ValueKey("Light"))
              : const Icon(Icons.dark_mode, key: ValueKey("Dark")),
        ),
      ),
    );
  }
}
