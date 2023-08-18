import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ユメステ レートシミュレータ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ユメステ レートシミュレータ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _perfectPlusValue = 0;
  double _perfectValue = 0;
  double _greateValue = 0;
  double _goodValue = 0;
  double _badValue = 0;
  double _missValue = 0;
  double _percent = 0;
  double? _difficurity;
  double? _rate;

  void _handleDifficurityValue(String e) {
    setState(() {
      _difficurity = double.tryParse(e)!;
    });
  }

  void _handlePerfectPlusValue(String e) {
    setState(() {
      _perfectPlusValue = double.tryParse(e)!;
      _percent = _calcPercent();
      _rate = _calcRate();
    });
  }

  void _handlePerfectValue(String e) {
    setState(() {
      _perfectValue = double.tryParse(e)!;
      _percent = _calcPercent();
      _rate = _calcRate();
    });
  }

  void _handleGreateValue(String e) {
    setState(() {
      _greateValue = double.tryParse(e)!;
      _percent = _calcPercent();
      _rate = _calcRate();
    });
  }

  void _handleGoodValue(String e) {
    setState(() {
      _goodValue = double.tryParse(e)!;
      _percent = _calcPercent();
      _rate = _calcRate();
    });
  }

  void _handleBadValue(String e) {
    setState(() {
      _badValue = double.tryParse(e)!;
      _percent = _calcPercent();
      _rate = _calcRate();
    });
  }

  void _handleMissValue(String e) {
    setState(() {
      _missValue = double.tryParse(e)!;
      _percent = _calcPercent();
      _rate = _calcRate();
    });
  }

  double _calcPercent() {
    final sum = _perfectPlusValue +
        _perfectValue +
        _greateValue +
        _goodValue +
        _badValue +
        _missValue;
    return (_perfectPlusValue * 101 +
            _perfectValue * 100 +
            _greateValue * 80 +
            _goodValue * 50) /
        sum;
  }

  double _revise(double v) {
    // https://gamerch.com/world-dai-star/entry/786842
    if (100.95 <= v) {
      return (v - 100.95) * 0.01 * 100 +
          (0.075 * 20) +
          (0.06 * 25) +
          (0.03 * 25) +
          (0.03 * 25) +
          (0.0075 * 200);
    }
    if (100.75 <= v) {
      return (v - 100.75) * 0.075 * 100 +
          (0.06 * 25) +
          (0.03 * 25) +
          (0.03 * 25) +
          (0.0075 * 200);
    }
    if (100.50 <= v) {
      return (v - 100.25) * 0.06 * 100 +
          (0.03 * 25) +
          (0.03 * 25) +
          (0.0075 * 200);
    }
    if (100.25 <= v) {
      return (v - 100.25) * 0.03 * 100 + (0.03 * 25) + (0.0075 * 200);
    }
    if (100.00 <= v) {
      return (v - 100.00) * 0.03 * 100 + 0.0075 * 200;
    }
    if (98.00 <= v) {
      return (v - 98.00) * 0.0075 * 100;
    }
    return 0.0;
  }

  double? _calcRate() {
    if (_difficurity == null) {
      return null;
    }
    return _difficurity! + _revise(_calcPercent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "レート: ${_rate?.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  "達成率: ${_percent.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 24),
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: '難易度',
                  ),
                  onChanged: _handleDifficurityValue,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'PERFECT+',
                  ),
                  onChanged: _handlePerfectPlusValue,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'PERFECT',
                  ),
                  onChanged: _handlePerfectValue,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'GREAT',
                  ),
                  onChanged: _handleGreateValue,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'GOOD',
                  ),
                  onChanged: _handleGoodValue,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'BAD',
                  ),
                  onChanged: _handleBadValue,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'MISS',
                  ),
                  onChanged: _handleMissValue,
                )
              ],
            ),
          ),
        ));
  }
}
