import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/fight_club_colors.dart';
import '../resources/fight_club_icons.dart';
import '../resources/fight_club_images.dart';
import '../widgets/action_button.dart';

class FightPage extends StatefulWidget {
  const FightPage({Key? key}) : super(key: key);

  @override
  State<FightPage> createState() => FightPageState();
}

class FightPageState extends State<FightPage> {
  static const maxLives = 5;
  String centerText = '';
  int wonCount = 0;
  int lostCount = 0;
  int drawCount = 0;

  BodyPart? defendingBodyPart;
  BodyPart? attakingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();

  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  // Color ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
                enemyLivesCount: enemysLives,
                yourLivesCount: yourLives,
                maxLivesCount: maxLives),
            const SizedBox(height: 30),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ColoredBox(
                color: FightClubColors.centerbackground,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                      child: Text(
                    centerText,
                    style: TextStyle(fontSize: 10),
                  )),
                ),
              ),
            )),
            const SizedBox(height: 30),
            ControlsWidget(
                attakingBodyPart: attakingBodyPart,
                defendingBodyPart: defendingBodyPart,
                selectDefendingBodyPart: _selectDefendingBodyPart,
                selectAttakingBodyPart: _selectAttakingBodyPart),
            SizedBox(height: 14),
            ActionButton(
                text: yourLives == 0 || enemysLives == 0 ? 'Back' : 'Go',
                onTap: _onGoButtonClicked,
                color: _getGoButtonColor()),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackButton;
    } else if (attakingBodyPart == null || defendingBodyPart == null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void _onGoButtonClicked() {
    if (yourLives == 0 || enemysLives == 0) {
      Navigator.of(context).pop();
    } else if (attakingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attakingBodyPart != whatEnemyDefends;
        final bool youLoseLife = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLife) {
          enemysLives -= 1;
        }

        if (youLoseLife) {
          yourLives -= 1;
        }

        final FightResult? fightResult =
            FightResult.calculateResult(yourLives, enemysLives);
        if (fightResult != null) {
          SharedPreferences.getInstance().then((SharedPreferences) {
            SharedPreferences.setString(
                'last_fight_result', fightResult.result);
            final String key = 'stats_${fightResult.result.toLowerCase()}';
            final    int currentValue =  SharedPreferences.getInt(key) ?? 0;
            SharedPreferences.setInt(key, currentValue + 1);
          });
        }
        centerText = _calculateCentreText(youLoseLife, enemyLoseLife);

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        attakingBodyPart = null;
        defendingBodyPart = null;

        //   ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.38);
      });
    }
  }

  String _calculateCentreText(
      final bool youLoseLife, final bool enemyLoseLife) {
    if (enemysLives == 0 && yourLives == 0) {
      return 'Draw';
    } else if (yourLives == 0) {
      return 'You lost';
    } else if (enemysLives == 0) {
      return 'You won';
    } else {
      final String first = enemyLoseLife
          ? "You hit enemy's ${attakingBodyPart!.name.toLowerCase()}."
          : "Your attack was blocked.";
      final String second = youLoseLife
          ? "Enemy hit your ${whatEnemyAttacks.name.toLowerCase()}."
          : "Enemy’s attack was blocked.";
      return "$first\n$second";
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      if (yourLives == 0 || enemysLives == 0) {
        return;
      }

      defendingBodyPart = value;
      if (attakingBodyPart != null && defendingBodyPart != null) {
        //  ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.87);
      }
    });
  }

  void _selectAttakingBodyPart(final BodyPart value) {
    setState(() {
      if (yourLives == 0 || enemysLives == 0) {
        return;
      }
      attakingBodyPart = value;
      if (attakingBodyPart != null && defendingBodyPart != null) {
        //  ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.87);
      }
    });
  }

}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemyLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemyLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
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
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: yourLivesCount),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text('You',
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                  SizedBox(height: 12),
                  Image.asset(FightClubImages.youAvatar, width: 92, height: 92)
                ],
              ),
              SizedBox(
                width: 44,
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FightClubColors.blueButton),
                  child: Center(
                    child: Text(
                      'vs',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
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
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: enemyLivesCount)
            ],
          ),
        ],
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> BodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.BodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: selected ? FightClubColors.blueButton : Colors.transparent,
              border: !selected
                  ? Border.all(color: FightClubColors.darkGreyText, width: 2)
                  : null),
          child: Center(
            child: Text(bodyPart.name.toUpperCase(),
                style: TextStyle(
                    color: selected
                        ? FightClubColors.whiteText
                        : FightClubColors.darkGreyText)),
          ),
        ),
      ),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attakingBodyPart;
  final ValueSetter<BodyPart> selectAttakingBodyPart;

  const ControlsWidget(
      {Key? key,
      required this.defendingBodyPart,
      required this.selectDefendingBodyPart,
      required this.attakingBodyPart,
      required this.selectAttakingBodyPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text('Defend'.toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                BodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                BodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                BodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text('Attack'.toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attakingBodyPart == BodyPart.head,
                BodyPartSetter: selectAttakingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attakingBodyPart == BodyPart.torso,
                BodyPartSetter: selectAttakingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attakingBodyPart == BodyPart.legs,
                BodyPartSetter: selectAttakingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        )
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(overallLivesCount, (index) {
          if (index < currentLivesCount) {
            return Padding(
              padding: index == 0
                  ? const EdgeInsets.only(top: 0)
                  : const EdgeInsets.only(top: 4),
              child:
                  Image.asset(FightClubIcons.heartFull, width: 18, height: 18),
            );
          } else
            return Padding(
              padding: index == 0
                  ? const EdgeInsets.only(top: 0)
                  : const EdgeInsets.only(top: 4),
              child:
                  Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18),
            );
        }),
      ),
    );
  }
}
