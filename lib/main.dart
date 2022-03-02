import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'fight_club_colors.dart';
import 'fight_club_images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;
  String Infotext = '';

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


            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: SizedBox( width: double.infinity, height: double.infinity, child: ColoredBox(child: Center(child: Text(Infotext, style: TextStyle(fontSize: 10),)), color: FightClubColors.centerbackground), ),
            )),


            ControlsWidget(
                attakingBodyPart: attakingBodyPart,
                defendingBodyPart: defendingBodyPart,
                selectDefendingBodyPart: _selectDefendingBodyPart,
                selectAttakingBodyPart: _selectAttakingBodyPart),
            SizedBox(height: 14),
            GoButton(
                text: yourLives == 0 || enemysLives == 0
                    ? 'Start new games'
                    : 'Go',
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
      setState(() {
        yourLives = maxLives;
        enemysLives = maxLives;
        Infotext = '';
      });
    } else if (attakingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        final bool enemyLoseLives = attakingBodyPart != whatEnemyDefends;
        final bool youLoseLives = defendingBodyPart != whatEnemyAttacks;

        if (enemyLoseLives) {
          enemysLives -= 1;

          final String? attakingBodyPartName = attakingBodyPart?.name.toLowerCase();
          Infotext  =  "You hit enemy’s $attakingBodyPartName. \n\nEnemy’s attack was blocked.";
        }

        if (youLoseLives) {
          yourLives -= 1;


          final String? attakingBodyPartName = attakingBodyPart?.name.toLowerCase();
          Infotext  =   "Your attack was blocked.\n\nEnemy hit your $attakingBodyPartName.  ";
        }

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        attakingBodyPart = null;
        defendingBodyPart = null;

        //   ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.38);
      });
    }

    if (yourLives == 0 && enemysLives == 0) {

      setState(() {
        Infotext = 'Draw';
      });

    }

    else if (yourLives == 0 && enemysLives > 0){

      setState(() {
        Infotext = 'You lost';
      });

    }

    else if (yourLives > 0 && enemysLives == 0){

      setState(() {
        Infotext = 'You won';
      });
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

  String _getText() {

    if (yourLives == 0 && enemysLives == 0) {
      return   'Draw';
    }

    else if (yourLives == 0 && enemysLives > 0){
      return   'You lost';
    }

    else if (yourLives > 0 && enemysLives == 0){
      return   'You won';
    }

 // else if (yourLives > 0 && enemysLives > 0){
 //     print(whatEnemyDefends);
 //   if (attakingBodyPart != null && attakingBodyPart == whatEnemyDefends){
 //     final String? attakingBodyPartName = attakingBodyPart?.name.toLowerCase();
 //     return   "Your attack was blocked.\n\nEnemy hit your $attakingBodyPartName.  ";

 //   }

 //   else  if (attakingBodyPart != null && attakingBodyPart != whatEnemyDefends)  {
 //     final String? attakingBodyPartName = attakingBodyPart?.name.toLowerCase();
 //     return   "You hit enemy’s $attakingBodyPartName. \n\nEnemy’s attack was blocked.";
 //       }


 //  /// attakingBodyPart
 //   print('enemy defend ' + whatEnemyDefends.name);
 //   print('enemy attak ' + whatEnemyAttacks.name);

 // //  print(attakingBodyPart);
 // //  print(defendingBodyPart);


 //   return   '';
 // }

      else {

    return   '';
    }

  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton(
      {Key? key, required this.text, required this.onTap, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
                child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: FightClubColors.whiteText,
              ),
            )),
          ),
        ),
      ),
    );
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
    return ColoredBox(
      color: Colors.yellow,
      child: SizedBox(
        height: 160,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ColoredBox(
                  color: FightClubColors.youbackground,
                )),
                Expanded(child: ColoredBox(
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
                    Text('You', style: TextStyle(color: FightClubColors.darkGreyText)),
                    SizedBox(height: 12),
                    Image.asset(FightClubImages.youAvatar, width: 92, height: 92)
                  ],
                ),

                ColoredBox(color: Colors.green, child: SizedBox(width: 44, height: 44)),

                Column(
                  children: [
                    SizedBox(height: 16),
                    Text('Enemy', style: TextStyle(color: FightClubColors.darkGreyText)),
                    SizedBox(height: 12),
                    Image.asset(FightClubImages.enemyAvatar, width: 92, height: 92)
                  ],
                ),
                LivesWidget(
                    overallLivesCount: maxLivesCount,
                    currentLivesCount: enemyLivesCount)

              ],
            ),
          ],
        ),
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
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
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
              padding: index == 0 ? const EdgeInsets.only(top: 0)
                  : const EdgeInsets.only(top: 4) ,
              child: Image.asset(FightClubIcons.heartFull, width: 18, height: 18),
            );
          } else
            return Padding(
              padding: index == 0 ? const EdgeInsets.only(top: 0)
                  : const EdgeInsets.only(top: 4),
              child: Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18),
            );
        }),
      ),
    );
  }
}
