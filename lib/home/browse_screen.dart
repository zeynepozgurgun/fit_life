import 'package:flutter/material.dart';
import 'package:fit_life/data/Diet.dart';
import 'package:fit_life/data/DietService.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  bool isForYouSelected = true; // To track which switch bar option is selected
  late Future<List<Diet>> _diets;  // Future to hold fetched diets

  @override
  void initState() {
    super.initState();
    _diets = DietService().fetchDiets();  // Fetch diets from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
        child: Column(
          children: [
            // Switch bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isForYouSelected = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isForYouSelected ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Text(
                        'For You',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isForYouSelected = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: !isForYouSelected ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: Text(
                        'Browse All',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Grid of clickable squares
            Expanded(
              child: FutureBuilder<List<Diet>>(
                future: _diets,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No diets found'));
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: snapshot.data!.length,  // Number of items in the data list
                      itemBuilder: (context, index) {
                        Diet diet = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            // Handle tap on each square
                            print('Tapped on ${diet.title}');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                diet.title,  // Display the name from your database
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

