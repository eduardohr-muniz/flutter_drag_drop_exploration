import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final persons = [
      PersonModel(name: "Eduardo", children: []),
      PersonModel(name: "Maite", children: []),
      PersonModel(name: "Ana Laura", children: []),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Drag & Drop Exploration'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                final child = Material(
                  color: Colors.amber,
                  child: InkWell(
                    onTap: () {
                      print('e');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.yellow,
                        child: Text(persons[index].name),
                      ),
                    ),
                  ),
                );

                return Draggable<PersonModel>(
                  data: persons[index],
                  feedback: child,
                  childWhenDragging: child,
                  child: child,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          DragTarget<PersonModel>(onAccept: (PersonModel person) {
            if (!persons.first.children.contains(person)) {
              persons.first.children.add(person);
            }
          }, builder: (context, candidateData, rejectedData) {
            print(candidateData.length);
            print(rejectedData.length);
            return Container(
              width: 300,
              height: 100,
              color: candidateData.isNotEmpty ? Colors.green : Colors.amber,
              child: Wrap(
                spacing: 10,
                children: persons.first.children.map((e) => Text(e.name)).toList(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class PersonModel {
  final String name;
  List<PersonModel> children;
  PersonModel({
    this.name = '',
    required this.children,
  });
}
