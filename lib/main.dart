import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController userInput = TextEditingController();
  double kelvin = 0.0;
  double reamur = 0.0;

  void konversiSuhu() {
    setState(() {
      final celcius = double.tryParse(userInput.text) ?? 0.0;
      kelvin = celcius + 273.15;
      reamur = celcius * 0.8;
    });
  }

  @override
  void dispose() {
    userInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Konverter Suhu',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Input(userInput: userInput),
              Result(kelvin: kelvin, reamur: reamur),
              convert(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton convert() {
    return TextButton(
      onPressed: konversiSuhu,
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: const Text('Konversi'),
    );
  }
}

class Result extends StatelessWidget {
  const Result({
    super.key,
    required this.kelvin,
    required this.reamur,
  });

  final double kelvin;
  final double reamur;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            const Text(
              'Suhu dalam Kelvin',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              kelvin.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'Suhu dalam Reamur',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              reamur.toStringAsFixed(2),
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.userInput,
  });

  final TextEditingController userInput;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Masukkan suhu dalam celcius',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      controller: userInput,
    );
  }
}
