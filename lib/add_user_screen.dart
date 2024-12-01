import 'package:flutter/material.dart';
import 'database_handler.dart';
import 'user.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late DatabaseHandler handler;
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController ageTextController = TextEditingController();
  final TextEditingController countryTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameTextController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: ageTextController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: countryTextController,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await handler.initializeDB();
                User newUser = User(
                  name: nameTextController.text,
                  age: int.parse(ageTextController.text),
                  country: countryTextController.text,
                );
                await handler.insertUser([newUser]);
                Navigator.pop(context, true); // Return success
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
