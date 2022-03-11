import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;


  const FightResultWidget({Key? key, required this.fightResult})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return


      SizedBox(
        height: 140,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: ColoredBox(
                      color: FightClubColors.youbackground,
                    )),
                Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            FightClubColors.youbackground,
                            FightClubColors.enemybackground
                          ])),
                    )),
                Expanded(
                    child: ColoredBox(
                      color: FightClubColors.enemybackground,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                Column(
                  children: [
                    const SizedBox(height: 16),
                    Text('You',
                        style: TextStyle(color: FightClubColors.darkGreyText)),
                    SizedBox(height: 12),
                    Image.asset(FightClubImages.youAvatar, width: 92, height: 92)
                  ],
                ),
                Container(
                  decoration: BoxDecoration( color: _getResultColor(),
                      borderRadius: BorderRadius.circular(22)),

                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  height: 44,
                  alignment: Alignment.center,
                  child: Text(fightResult.result.toLowerCase(), style: TextStyle(
                      fontSize: 16,
                      color: FightClubColors.colorwhite,
                      fontWeight: FontWeight.w400),),
                ),
                Column(
                  children: [
                    SizedBox(height: 16),
                    Text('Enemy',
                        style: TextStyle(color: FightClubColors.darkGreyText)),
                    SizedBox(height: 12),
                    Image.asset(FightClubImages.enemyAvatar,
                        width: 92, height: 92)
                  ],
                ),
              ],
            ),
          ],
        ),
      );
  }

  _getResultColor() {
    if (fightResult == FightResult.won) {
      return  Color.fromRGBO(3, 136, 0, 1);
    } else if (fightResult == FightResult.lost) {
      return Color.fromRGBO(234, 44, 44, 1);
    } else {
      return Color.fromRGBO(28, 121, 206, 1);
    }

  }
}
