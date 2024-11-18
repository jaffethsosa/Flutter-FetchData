import 'package:flutter/material.dart';
import 'package:flutter_fecth_data/API/api_res.dart';
import 'package:flutter_fecth_data/screen/cocktail/cocktail_screen.dart';

class ListdrinksScreen extends StatelessWidget {
  const ListdrinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Drinks'),
      ),
      body: FutureBuilder(
        future: Future.wait([fetchCocktailsDrinksA(), fetchCocktailsDrinksNA()]),
        builder: (context, AsyncSnapshot<List<List<dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading drinks.'));
          } else {
            final alcoholicDrinks = snapshot.data![0];
            final nonAlcoholicDrinks = snapshot.data![1];

            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Alcoholic Drinks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...alcoholicDrinks.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final drink = entry.value;
                        final idDrink = drink['idDrink'];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoctailDetailsScreen(idDrink: idDrink),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Text('$index.'),
                              title: Text(drink['strDrink']),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Non-Alcoholic Drinks',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...nonAlcoholicDrinks.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final drink = entry.value;
                        final idDrink = drink['idDrink'];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoctailDetailsScreen(idDrink: idDrink),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Text('$index.'),
                              title: Text(drink['strDrink']),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
