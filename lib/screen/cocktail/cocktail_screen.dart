import 'package:flutter/material.dart';
import 'package:flutter_fecth_data/API/api_res.dart';

class CoctailDetailsScreen extends StatelessWidget {
  final String idDrink;

  const CoctailDetailsScreen({super.key, required this.idDrink});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cocktail Details'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Feedback'),
            ],
          ),
        ),
        body: FutureBuilder(
          future: fetchCocktailDetails(idDrink),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading cocktail details.'));
            } else {
              final drinkDetails = snapshot.data!;

              return TabBarView(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(drinkDetails['strDrinkThumb'], height: 200),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Name: ${drinkDetails['strDrink']}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Description: ${drinkDetails['strInstructions']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Alcohol: ${drinkDetails['strAlcoholic'] ?? "Unknown"}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Ingredients:',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        ..._buildIngredients(drinkDetails),
                        const SizedBox(height: 16),
                        Text(
                          'Glass: ${drinkDetails['strGlass']}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Please select your feedback:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        FeedbackSelection(),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  List<Widget> _buildIngredients(Map<String, dynamic> drink) {
    List<Widget> ingredientWidgets = [];
    for (int i = 1; i <= 15; i++) {
      var ingredientKey = 'strIngredient$i';
      if (drink[ingredientKey] != null && drink[ingredientKey].isNotEmpty) {
        ingredientWidgets.add(Text(
          drink[ingredientKey],
          style: const TextStyle(fontSize: 16),
        ));
      }
    }
    return ingredientWidgets;
  }
}

class FeedbackSelection extends StatefulWidget {
  const FeedbackSelection({super.key});

  @override
  _FeedbackSelectionState createState() => _FeedbackSelectionState();
}

class _FeedbackSelectionState extends State<FeedbackSelection> {
  String? _selectedFeedback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('Excellent'),
          value: 'Excellent',
          groupValue: _selectedFeedback,
          onChanged: (value) {
            setState(() {
              _selectedFeedback = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Good'),
          value: 'Good',
          groupValue: _selectedFeedback,
          onChanged: (value) {
            setState(() {
              _selectedFeedback = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Average'),
          value: 'Average',
          groupValue: _selectedFeedback,
          onChanged: (value) {
            setState(() {
              _selectedFeedback = value;
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Poor'),
          value: 'Poor',
          groupValue: _selectedFeedback,
          onChanged: (value) {
            setState(() {
              _selectedFeedback = value;
            });
          },
        ),
      ],
    );
  }
}
