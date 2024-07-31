import 'package:flutter/material.dart';
import 'package:fit_life/data/Diet.dart';
import 'package:fit_life/data/DietService.dart';
import 'package:fit_life/home/diet_details.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  bool isForYouSelected = true;
  late Future<List<Diet>> _diets;

  @override
  void initState() {
    super.initState();
    _diets = DietService().fetchDiets();  // Fetch diets from Firestore
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
        child: Column(
          children: [
            // Switch bar
            Container(
  decoration: BoxDecoration(
    border: Border.all(color: colorScheme.onSecondary , width: 1), // Outline 
    borderRadius: BorderRadius.circular(50),
  ),
         child:  Row(
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
                      color: isForYouSelected ? colorScheme.onPrimary : colorScheme.surface, // FOR YOU
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(40)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      'For You',
                      style: Theme.of(context).textTheme.displaySmall,
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
                      color: !isForYouSelected ? colorScheme.onPrimary : colorScheme.surface, // BROWSE ALL
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      'Browse All',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ],
          ),
            ),

            SizedBox(height: 20),
            // Search bar
            TextField(
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Search for keywords',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  
                  borderRadius: BorderRadius.circular(50),
                   
                ),
              ),
            ),
            SizedBox(height: 10),
            

            //CLICKABLE DIETS
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DietDetailScreen(diet: diet),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.5), // Adding a semi-transparent color
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Background image with 50% opacity
                                Opacity(
                                  opacity: 0.5,
                                  child: Image.network(
                                    diet.imageUrl,
                                    fit: BoxFit.cover, // Make sure the image covers the container
                                  ),
                                ),
                                // Centered text
                                Center(
                                  child: Text(
                                    diet.title,
                                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                      //color: Colors.white, // Make sure the text is readable on the image
                                      backgroundColor: Colors.white.withOpacity(0.5), // Optional: Adds a background color to the text
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

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
