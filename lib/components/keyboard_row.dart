import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle_app/constants/answer_stages.dart';
import 'package:wordle_app/constants/colors.dart';

import '../providers/controller.dart';
import '../data/keys_map.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({required this.min, required this.max,
    Key? key,
  }) : super(key: key);

  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Consumer<Controller>(
      builder: (_,notifier, __) {
        int index = 0;
        return IgnorePointer(
          ignoring: notifier.gameCompleted,
          child: Row(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: keysMap.entries.map((e){
            index++;
            if(index >= min && index <=max)
              {
                Color color = Theme.of(context).primaryColorLight;
                Color keyColor = Colors.white;
                if(e.value == AnswerStage.correct)
                  {
                    color = correctGreen;
                  }
                else if(e.value == AnswerStage.contains)
                {
                  color = containsYellow;
                }
                else if(e.value == AnswerStage.incorrect)
                {
                  color = Theme.of(context).primaryColorDark;
                }
                else
                  {
                    keyColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
                  }
          
                return Padding(
                  padding:  EdgeInsets.all(deviceSize.width * 0.006),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: SizedBox(
                        width: e.key == 'ENTER' || e.key == "BACK" ?  deviceSize.width * 0.135 : deviceSize.width * 0.085 ,
                        height: deviceSize.height * 0.09,
                       child:Material(
                         color: color,
                         child: InkWell(
                             onTap: (){
                               Provider.of<Controller>(context, listen: false).setKeyTapped(value: e.key);
                             },
                             child: Center(child: Text(e.key, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                               color: keyColor
                             ) ,))),
                       ),),
                  )
                );
              }
                 else
           {
             return const SizedBox();
           }
                }).toList(),
                ),
        );
      },
    );
  }
}