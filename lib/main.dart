import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter compteur voyelle',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final vowelCount = {'a': 0, 'e': 0, 'i': 0, 'o': 0, 'u': 0};
  int consonantCount = 0;
  String word = '';

  void _analyzeWord() {
    setState(() {
      vowelCount.clear();
      consonantCount = 0;
      if (word.isNotEmpty) {
        word.toLowerCase().split('').forEach((char) {
          if ('aeiou'.contains(char)) {
            vowelCount[char] = (vowelCount[char] ?? 0) + 1;
          } else if ('bcdfghjklmnpqrstvwxyz'.contains(char)) {
            consonantCount++;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('ANALYSE VOYELLE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              
              onChanged: (value) {
                setState(() {
                  word = value;
                });
              },
              decoration:  InputDecoration(
                
                labelText: 'Entrez un mot',
                hintText: "Entrez un mot",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _analyzeWord,
              child: const Text('Analyser'),
            ),
            const SizedBox(height: 16.0),
            ...vowelCount.entries.map((entry) {
              final color = entry.key == 'a'
                  ? Colors.red
                  : entry.key == 'e'
                      ? Colors.orange
                      : entry.key == 'i'
                          ? Colors.yellow
                          : entry.key == 'o'
                              ? Colors.green
                              : Colors.blue; // Default for 'u'
              return Text(
                '${entry.key}: ${entry.value} occurences',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              );
            }),
            const SizedBox(height: 16.0),
            Text(
              'Consonnes: $consonantCount occurences',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}