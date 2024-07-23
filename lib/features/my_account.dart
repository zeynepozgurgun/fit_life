import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'navigation_bar.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Yellow circle on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: colorScheme.onPrimary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(360),
                ),
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'My Account',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),

          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'username',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),

          // Profile Picture Circle
          Positioned(
            top: 180,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey) : null,
                ),
              ),
            ),
          ),

          Positioned(
            top: 300,
            left: 50,
            right: 50,
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildInputFieldRow(context, 'Goal:', DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)
                    ),

                    items: <String>['Option 1', 'Option 2', 'Option 3'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    style: Theme.of(context).textTheme.displaySmall,
                  )),

                  const SizedBox(height: 10),

                  buildInputFieldRow(context, 'Age:', TextField(
                    
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)
                    ),
                    style: Theme.of(context).textTheme.displaySmall,
                  )),

                  const SizedBox(height: 10),

                  buildInputFieldRow(context, 'Height:', TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)
                    ),
                    style: Theme.of(context).textTheme.displaySmall,
                  )),

                  const SizedBox(height: 10),

                  buildInputFieldRow(context, 'Weight:', TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)
                    ),
                    style: Theme.of(context).textTheme.displaySmall,
                  )),

                  const SizedBox(height: 10),

                  buildInputFieldRow(context, 'See diets for:', DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)
                    ),
                    items: <String>['Men', 'Women', 'Unisex'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    style: Theme.of(context).textTheme.displaySmall,
                  )),

                  const SizedBox(height: 10),

                  buildInputFieldRow(context, 'Preferences:', DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0)
                    ),
                    items: <String>['Gluten-free', 'Vegan', 'Vegetarian', 'Lactose-Free'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                    style: Theme.of(context).textTheme.displaySmall,
                  )),

                  const SizedBox(height: 20),
                Center( // Center the button
                  child: ElevatedButton(
                    onPressed: () {
                      
                    },
                    child: Text('Save Changes'),
                    
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: colorScheme.onSecondary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget buildInputFieldRow(BuildContext context, String label, Widget inputField) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.left, 
            ),
          ),
          SizedBox(width: 200, child: inputField),

        ],
      ),
    );
  }
}
