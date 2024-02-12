import 'package:dhikr_app/pages/dhikr_page.dart';
import 'package:flutter/material.dart';
import 'model/Dhikr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dzikr App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Your Dhikr App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Dhikr> dhikr = [
    Dhikr(
        id: 1,
        title: "Dhikr1",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 2,
        title: "Dhikr2",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 3,
        title: "Dhikr3",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 4,
        title: "Dhikr4",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 5,
        title: "Dhikr5",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 6,
        title: "Dhikr6",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 7,
        title: "Dhikr7",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 8,
        title: "Dhikr8",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 9,
        title: "Dhikr9",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 10,
        title: "Dhikr10",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 11,
        title: "Dhikr11",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
    Dhikr(
        id: 12,
        title: "Dhikr12",
        arabicText: "1234",
        indonesianTranslation: "Indonesia",
        englishTranslation: "English",
        isMorning: true,
        isEvening: true,
        references: ["1st ref", "2nd ref"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: dhikr.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(dhikr[index].title);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DhikrPage(dhikr: dhikr[index],)));
              },
              child: Container(
                height: 65,
                margin: const EdgeInsets.all(10),
                color: Colors.cyanAccent,
                child: Center(
                  child: Text(
                    '${dhikr[index].title}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ));
  }

  ListView buildListView() {
    return ListView(
      children: [
        Container(
          height: 65,
          color: Colors.amber[600],
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: const Center(child: Text('Entry A')),
        ),
        Container(
          height: 65,
          color: Colors.amber[500],
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: const Center(child: Text('Entry B')),
        ),
        Container(
          height: 65,
          color: Colors.amber[100],
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: const Center(child: Text('Entry C')),
        ),
      ],
    );
  }
}
