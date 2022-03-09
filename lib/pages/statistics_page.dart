import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _StatisticsPage();
  }
}

class _StatisticsPage extends StatelessWidget {
  const _StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
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
            Column(
              children: [
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                          (sharedPreferences) =>
                          sharedPreferences.getInt('stats_won')),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Text('Won: 0', style: TextStyle(
                          fontSize: 16,
                          color: FightClubColors.darkGreyText,
                          fontWeight: FontWeight.w400
                      ),);
                    }

                    return Text('Won:${snapshot.data.toString()}', style: TextStyle(
                        fontSize: 16,
                        color: FightClubColors.darkGreyText,
                        fontWeight: FontWeight.w400
                    ),);
                    //       fightResult.  = snapshot.data;
                  },
                ),

                SizedBox(height: 40),
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                          (sharedPreferences) =>
                          sharedPreferences.getInt('stats_draw')),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Text('Draw: 0', style:TextStyle(
                          fontSize: 16,
                          color: FightClubColors.darkGreyText,
                          fontWeight: FontWeight.w400
                      ));
                    }

                    return Text('Draw:${snapshot.data.toString()}', style: TextStyle(
                        fontSize: 16,
                        color: FightClubColors.darkGreyText,
                        fontWeight: FontWeight.w400
                    ),);
                    //       fightResult.  = snapshot.data;
                  },
                ),
                SizedBox(height: 40),
                FutureBuilder<int?>(
                  future: SharedPreferences.getInstance().then(
                          (sharedPreferences) =>
                          sharedPreferences.getInt('stats_lost')),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return Text('Lost: 0', style:TextStyle(
                          fontSize: 16,
                          color: FightClubColors.darkGreyText,
                          fontWeight: FontWeight.w400
                      ));
                    }

                    return Text('Lost:${snapshot.data.toString()}', style: TextStyle(
                        fontSize: 16,
                        color: FightClubColors.darkGreyText,
                        fontWeight: FontWeight.w400
                    ),);
                    //       fightResult.  = snapshot.data;
                  },
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SecondaryActionButton(
                  text: 'Back',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
