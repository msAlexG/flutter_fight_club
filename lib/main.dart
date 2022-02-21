import 'package:flutter/material.dart';

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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attakingBodyPart;
  Color ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 222, 240, 1),
      body: Column(
        children: [
          SizedBox(height: 40),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: Center(child: Text('You'))),
              SizedBox(width: 12),
              Expanded(child: Center(child: Text('Enemy'))),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 11),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14),)))),
              SizedBox(width: 12),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 12),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 12),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 12),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 12),
              Expanded(child: SizedBox(width: 8, height: 16 ,child: Center(child: Text('1', style: TextStyle(fontSize: 14))))),
              SizedBox(width: 16)
            ],
          ),

          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
                    Text('Defend'.toUpperCase()),
                    SizedBox(height: 13),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      BodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: defendingBodyPart == BodyPart.torso,
                      BodyPartSetter: _selectDefendingBodyPart,
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
                    Text('Attack'.toUpperCase()),
                    SizedBox(height: 13),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: attakingBodyPart == BodyPart.head,
                      BodyPartSetter: _selectAttakingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: attakingBodyPart == BodyPart.torso,
                      BodyPartSetter: _selectAttakingBodyPart,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 16,
              )
            ],
          ),
          SizedBox(height: 14),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  //  print(attakingBodyPart);
                  // print(defendingBodyPart);

                  if (attakingBodyPart != null && defendingBodyPart != null) {
                    setState(() {
                      attakingBodyPart = null;
                      defendingBodyPart = null;
                      ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.38);
                    });
                    // print('da');

                  }
                },
                child: SizedBox(
                  height: 40,
                  child: ColoredBox(
                    color: ColorButtonGo,
                    child: Center(
                        child: Text(
                      'Go'.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              )),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
      if (attakingBodyPart != null && defendingBodyPart != null) {
        ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.87);
      }
    });
  }

  void _selectAttakingBodyPart(final BodyPart value) {
    setState(() {
      attakingBodyPart = value;
      if (attakingBodyPart != null && defendingBodyPart != null) {
        ColorButtonGo = Color.fromRGBO(0, 0, 0, 0.87);
      }
    });
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
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
              ? const Color.fromRGBO(28, 121, 206, 1)
              : Color.fromRGBO(0, 0, 0, 0.38),
          child: Center(
            child: Text(bodyPart.name.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
