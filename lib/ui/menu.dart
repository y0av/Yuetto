import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Image, Gradient;
import 'package:pinball/game.dart';
import 'package:pinball/ui/menu_card.dart';
import 'package:pinball/utils/app_theme.dart';
import 'package:pinball/utils/levels_data.dart';

class Menu extends StatelessWidget {
  const Menu(this.game, {super.key});

  final PinballGame game;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Wrap(
          children: [
            Column(
              children: [
                MenuCard(
                  children: [
                    Text(
                      'Yuetto game',
                      style: textTheme.displayLarge,
                    ),
                    Text(
                      'Sound on!',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Level 1'),
                      onPressed: () {
                        game.startLevel(level1Data);
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      child: const Text('Level 2'),
                      onPressed: () {
                        game.startLevel(level2Data);
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                MenuCard(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Made by ',
                            style: textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: 'Yoav',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppTheme.shadow,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
/*                                launchUrl(
                                  Uri.parse('https://github.com/y0av/pinball'),
                                );*/
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
