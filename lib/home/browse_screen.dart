import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:fit_life/data/diet.dart';
import 'package:fit_life/home/diet_details.dart';
import 'package:fit_life/methods/mixins/diet_mixin.dart';
import 'package:fit_life/globals.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> with DietMixin {
  bool isForYouSelected = true;
  late Future<List<Diet>> _diets;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _diets = Future.value([]); 
    _loadDiets();
  }

  Future<void> _loadDiets() async {
    final userId = firebase_auth.FirebaseAuth.instance.currentUser!.uid;
    final diets = await loadDiets(userId, searchQuery, isForYouSelected);

    if (!mounted) return;

    setState(() {
      _diets = Future.value(diets);
    });
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
                border: Border.all(color: colorScheme.onSecondary, width: 1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isForYouSelected = true;
                          if (isAuthenticated){
                            _loadDiets();
                          }
                          else{
                            _diets = Future.value([]);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isForYouSelected ? colorScheme.onPrimary : colorScheme.surface,
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
                          _loadDiets();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: !isForYouSelected ? colorScheme.onPrimary : colorScheme.surface,
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
              style: Theme.of(context).textTheme.displaySmall,
              decoration: InputDecoration(
                hintText: 'Search for keywords',
                hintStyle: Theme.of(context).textTheme.displaySmall,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                  _loadDiets();
                });
              },
            ),
            SizedBox(height: 10),
            // Diet list
            Expanded(
              child: FutureBuilder<List<Diet>>(
                future: _diets,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    if (isAuthenticated){
                      return Center(child: Text('No diets found'));
                    }
                    else{
                      return Center(child: Text('Log in to see personalized diets!'));
                    }
                    
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: snapshot.data!.length,
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
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Opacity(
                                    opacity: 0.5,
                                    child: Image.network(
                                      diet.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      diet.title,
                                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                        backgroundColor: Colors.white.withOpacity(0.5),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
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
