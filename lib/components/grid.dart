import 'package:flutter/material.dart';
import 'package:wordle_app/animations/bounce.dart';
import 'package:wordle_app/animations/win.dart';
import 'package:wordle_app/components/tile.dart';

import '../providers/controller.dart';
import 'package:provider/provider.dart';

class Grid extends StatelessWidget {

  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        int level = notifier.level;
        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
          itemCount: level * 6,
          // Możesz teraz kontrolować ilość elementów na podstawie `notifier.level`
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: level,
            // Kontroluj liczbę kolumn za pomocą poziomu z kontrolera
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {

            
            return Consumer<Controller>(
              builder:(_, notifier, __) {
                bool animate = false;
                bool winAnimation = false;
                int winDelay = 1600;
                if(index == notifier.currentTile - 1 && !notifier.backOrEnterTapped)
                  {
                    animate = true;
                  }
                if(notifier.gameWon)
                  {
                for(int i = notifier.tilesEntered.length - notifier.level; i <notifier.tilesEntered.length; i++ ) {
                  if (index == i) {
                    winAnimation = true;
                    winDelay += 150 * (i - (notifier.currentRow - 1) * notifier.level);
                  }
                }
                  }
                return Win(
                  animate: winAnimation,
                  delay: winDelay,
                  child: Bounce(
                  aniamte: animate,
                    child: Tile(index: index)),
                );
              },
            );
          },
        );
      },
    );
  }
}