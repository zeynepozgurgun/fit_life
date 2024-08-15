import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'dart:io';
import 'package:fit_life/data/options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_life/methods/snack_bar_mixin.dart';
import 'package:fit_life/methods/classes.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> with SnackBarMixin {
  File? _image;
  List<String> _selectedGoals = [];
  List<String> _selectedGenders = [];
  List<String> _selectedPreferences = [];

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user != null) {
        final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;

          setState(() {
            _selectedGoals = List<String>.from(data['goal'] ?? []);
            _selectedGenders = List<String>.from(data['gender'] ?? []);
            _selectedPreferences = List<String>.from(data['preferences'] ?? []);

            _ageController.text = data['age']?.toString() ?? '';
            _heightController.text = data['height']?.toString() ?? '';
            _weightController.text = data['weight']?.toString() ?? '';
            
            if (data.containsKey('profile_picture')) {
              _image = File(data['profile_picture']);
            }
          });
        }
      }
    } catch (e) {
      // Handle error
      print('Error loading user data: ${e.toString()}');
    }
  }

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
            top: 130,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'My Account',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
          /*
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
          ), */
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
                  ////////////////////////
                  InputFieldRow(
                    label: 'Goal:',
                    child: MultiSelectDialogField<String>(
                      items: goalOptions.map((String goal) {
                        return MultiSelectItem<String>(goal, goal);
                      }).toList(),
                      initialValue: _selectedGoals,
                      onConfirm: (List<String> selected) {
                        setState(() {
                          _selectedGoals = selected;
                        });
                      },
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      buttonText: 
                      Text(
                        _selectedGoals.isEmpty ? 'choose all that apply' : _selectedGoals.join(', '),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(scroll:true),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputFieldRow(
                    label: 'Age:',
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                      ),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputFieldRow(
                    label: 'Height:\n(in cm)',
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                      ),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputFieldRow(
                    label: 'Weight:\n(in kg)',
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
                      ),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputFieldRow(
                    label: 'See diets for:',
                    child: MultiSelectDialogField<String>(
                      items: genderOptions.map((String gender) {
                        return MultiSelectItem<String>(gender, gender);
                      }).toList(),
                      initialValue: _selectedGenders,
                      onConfirm: (List<String> selected) {
                        setState(() {
                          _selectedGenders = selected;
                        });
                      },
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      buttonText: 
                      Text(
                        _selectedGenders.isEmpty ? 'choose all that apply' : _selectedGenders.join(', '),
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InputFieldRow(
                    label: 'Preferences:',
                    child: MultiSelectDialogField<String>(
                      items: preferenceOptions.map((String pref) {
                        return MultiSelectItem<String>(pref, pref);
                      }).toList(),
                      initialValue: _selectedPreferences,
                      onConfirm: (List<String> selected) {
                        setState(() {
                          _selectedPreferences = selected;
                        });
                      },
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      buttonText: 
                      Text(
                        _selectedPreferences.isEmpty ? 'choose all that apply' : _selectedPreferences.join(', '),
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      chipDisplay: MultiSelectChipDisplay.none(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        final String ageText = _ageController.text;
                        final String heightText = _heightController.text;
                        final String weightText = _weightController.text;

                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final User? user = auth.currentUser;

                          if (user != null) {
                            final int age = int.tryParse(ageText) ?? 0; // parses age text to int or use 0 if parsing fails
                            final int height = int.tryParse(heightText) ?? 0;
                            final int weight = int.tryParse(weightText) ?? 0;

                            await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                              'goal': _selectedGoals, 
                              'age': age,
                              'height': height,
                              'weight': weight,
                              'gender': _selectedGenders,
                              'preferences': _selectedPreferences,
                            });

                            showSnackBar(context, 'Your changes have been saved.');

                            await Future.delayed(Duration(seconds: 2));

                          } else {
                            showSnackBar(context, 'No user is logged in.');
                          }
                        } catch (e) {
                          showSnackBar(context, 'An error occurred: ${e.toString()}');
                        }
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
    );
  }
}

