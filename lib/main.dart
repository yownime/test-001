import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dongeng Anak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DongengListPage(),
    );
  }
}

class DongengListPage extends StatefulWidget {
  const DongengListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DongengListPageState createState() => _DongengListPageState();
}

class _DongengListPageState extends State<DongengListPage> {
  List<String> dongengList = [
    'Si Kancil',
    'Timun Mas',
    'Batu Menangis',
    'Bawang Merah Bawang Putih',
  ];

  List<String> filteredDongengList = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDongengList = dongengList;
  }

  void filterDongengList(String query) {
    setState(() {
      filteredDongengList = dongengList
          .where((dongeng) => dongeng.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dongeng Anak'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? selected = await showSearch(
                context: context,
                delegate: DongengSearchDelegate(dongengList),
              );

              if (selected != null && selected.isNotEmpty) {
                // Handle selected dongeng
                ('Selected Dongeng: $selected');
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredDongengList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredDongengList[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DongengDetailPage(dongengTitle: filteredDongengList[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {
                // Implement bookmark functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                // Implement like functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DongengSearchDelegate extends SearchDelegate<String> {
  final List<String> dongengList;

  DongengSearchDelegate(this.dongengList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? dongengList
        : dongengList
            .where((dongeng) =>
                dongeng.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}

class DongengDetailPage extends StatelessWidget {
  final String dongengTitle;

  const DongengDetailPage({super.key, required this.dongengTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dongengTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Implement like functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Implement bookmark functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Deskripsi dongeng...',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  // Implement like functionality
                },
              ),
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed: () {
                  // Implement bookmark functionality
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DongengReadPage(dongengTitle: dongengTitle),
                    ),
                  );
                },
                child: Text('Baca'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DongengReadPage extends StatelessWidget {
  final String dongengTitle;

  const DongengReadPage({super.key, required this.dongengTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dongengTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cerita dongeng...',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement zoom in functionality
              },
              child: Text('Zoom In'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement zoom out functionality
              },
              child: Text('Zoom Out'),
            ),
          ],
        ),
      ),
    );
  }
}
