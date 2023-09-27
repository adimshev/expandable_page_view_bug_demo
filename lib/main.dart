import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = PageController(viewportFraction: 0.9);

  var _key = const Key('');
  var estimatedPageSize = 0.0;

  late final _children = [
    _buildChild('First'),
    _buildChild('Second'),
    _buildChild('Third'),
  ];

  late var children = _children;

  void reset() {
    setState(() {
      _key = Key(_key.hashCode.toString());
    });
  }

  Widget _buildChild(String title) {
    return Container(
      margin: const EdgeInsets.all(8),
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('expandable_page_view bug'),
      ),
      body: Column(
        children: [
          ExpandablePageView(
            key: _key,
            controller: controller,
            estimatedPageSize: estimatedPageSize,
            children: children,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                children = children != _children
                    ? _children
                    : [
                        _children[0],
                        _children[1],
                      ];
              });
            },
            child: Text('Length: ${children.length}'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                estimatedPageSize = estimatedPageSize == 0.0 ? 50 : 0;
              });
            },
            child: Text('EstimatedPageSize: $estimatedPageSize'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reset,
        tooltip: 'reset',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
