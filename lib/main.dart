import 'package:flutter/material.dart';
import 'package:image_hover_detail/hover.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Hover Image With Details',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Hover Image With Details'),
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: const Row(
          children: [
            Expanded(
              child: HoverCard(
                  image:
                      "https://cdn.pixabay.com/photo/2023/06/29/10/33/lion-8096155_640.png"),
            ),
            Expanded(
              child: HoverCard(
                  image:
                      "https://cdn.pixabay.com/photo/2017/10/20/10/58/elephant-2870777_640.jpg"),
            ),
            Expanded(
              child: HoverCard(
                  image:
                      "https://cdn.pixabay.com/photo/2018/05/11/11/11/horse-3390256_640.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
