import 'package:flutter/material.dart';

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({Key? key}) : super(key: key);

  @override
  State<AutoCompleteTextField> createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  bool isChanged = false;
  List<Continent> continentOptions = <Continent>[
    Continent(name: 'africa', size: 30370000),
    Continent(name: 'antarctica', size: 14000000),
    Continent(name: 'asia', size: 44579000),
    Continent(name: 'asia', size: 44579000),
    Continent(name: 'asia', size: 44579000),
    Continent(name: 'australia', size: 8600000),
    Continent(name: 'aurope', size: 10180000),
    Continent(name: 'aorth America', size: 24709000),
    Continent(name: 'aouth America', size: 17840000),
  ];
  List continent = [];
  TextEditingController serchController = TextEditingController();
  List<Continent> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = continentOptions;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Continent> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = continentOptions;
    } else {
      results = continentOptions
          .where((element) =>
              element.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //  AutoCompleteExample(),
                (_foundUsers.isNotEmpty)
                    ? Column(
                        children: List.generate(_foundUsers.length, (index) {
                        return ListTile(
                          title: Text(_foundUsers[index].name),
                          onTap: () {
                            setState(() {
                              serchController.text = _foundUsers[index].name;
                            });
                          },
                        );
                      }))
                    : const Text(
                        'No results found Please try with diffrent search',
                        style: TextStyle(fontSize: 15),
                      ),
                TextField(
                  controller: serchController,
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15),
                    hintText: "Search",
                    suffixIcon: const Icon(Icons.search),
                    // prefix: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Continent {
  const Continent({
    required this.name,
    required this.size,
  });

  final String name;
  final int size;

  @override
  String toString() {
    return '$name ($size)';
  }
}
