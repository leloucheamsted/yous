import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:youscribe/styles/youscribe_theme.dart';
import 'package:youscribe/utilities/floating_player_control.dart';
import 'package:youscribe/utilities/youscribe_premium.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => YouScribeTheme()..loadThemePreference()),
        ChangeNotifierProvider(
            create: (_) =>
                YouScribePremium()..loadUserStatePremiumSubscription()),
        ChangeNotifierProvider(
            create: (_) =>
                FloatingPlayerControl()..changePlayingState(AudioPlayer())),
      ],
      child: child,
    );
  }
}
