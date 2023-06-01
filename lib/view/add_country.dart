import 'package:flutter/material.dart';
import 'package:university_find/view/home_page.dart';

class AddingCountry extends StatefulWidget {
  const AddingCountry({super.key});

  @override
  State<AddingCountry> createState() => _AddingCountryState();
}

class _AddingCountryState extends State<AddingCountry> {
  TextEditingController countryResult = TextEditingController();

  @override
  void dispose() {
    countryResult.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search University')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextFormField(
              controller: countryResult,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(country: countryResult.text),
                ),
                (route) => false,
              );
            },
            child: const Icon(Icons.done),
          )
        ],
      ),
    );
  }
}
