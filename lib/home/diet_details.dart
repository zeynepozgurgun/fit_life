import 'package:flutter/material.dart';
import 'package:fit_life/data/diet.dart';

class DietDetailScreen extends StatelessWidget {
  final Diet diet;

  const DietDetailScreen({Key? key, required this.diet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final double containerWidth = MediaQuery.of(context).size.width - 32; // Adjust as needed

    return Scaffold(
      appBar: AppBar(
        title: Text(
          diet.title,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(diet.imageUrl),
              ),
              SizedBox(height: 16),
              Text(
                'What is ${diet.title}?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  minWidth: containerWidth,
                  maxWidth: containerWidth,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  diet.description,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'What to Eat?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  minWidth: containerWidth,
                  maxWidth: containerWidth,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: diet.whatToEat
                      .map(
                        (item) => Text(
                          '- $item',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'What to Avoid?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  minWidth: containerWidth,
                  maxWidth: containerWidth,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: diet.whatToAvoid
                      .map(
                        (item) => Text(
                          '- $item',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Who Should Avoid?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                constraints: BoxConstraints(
                  minWidth: containerWidth,
                  maxWidth: containerWidth,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: diet.whoShouldAvoid
                      .map(
                        (item) => Text(
                          '- $item',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
