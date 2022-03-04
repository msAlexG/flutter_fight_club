import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage  extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _StatisticsPage();
  }
}


class _StatisticsPage  extends StatelessWidget {
  const _StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(child:
      Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              'Statistics',
              style: TextStyle(
                fontSize: 24,
                color: FightClubColors.darkGreyText,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical:16 ),
            child: SecondaryActionButton(
                text: 'Back', onTap: () {

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MainPage(),
              ));

            }),
          ),


        ],
      )
        ,


      ),
    );
  }
}
