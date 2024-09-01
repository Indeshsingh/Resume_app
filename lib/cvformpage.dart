import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:resume_app/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Cvformpage extends StatefulWidget {
  const Cvformpage({super.key});

  @override
  _CvformpageState createState() => _CvformpageState();
}

class _CvformpageState extends State<Cvformpage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _designationController = TextEditingController();
  final _githubLinkController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _collegeNameController = TextEditingController();
  final _degreeNameController = TextEditingController();
  final _educationCityController = TextEditingController();
  final _jobtitleController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _organizationController = TextEditingController();
  final _jobCityController = TextEditingController();
  final _summaryController = TextEditingController();
  final _hobbiesController = TextEditingController();
  final _languagesController = TextEditingController();
  final _photoController = TextEditingController();

  // Image picker instance
  final picker = ImagePicker();
  XFile? _pickedImage;

  // Function to submit the form
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      String photoUrl = '';

      // Upload the photo to Firebase Storage and get its URL
      if (_pickedImage != null) {
        final file = File(_pickedImage!.path);
        final fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
        final reference =
            FirebaseStorage.instance.ref().child('photos/$fileName');

        try {
          TaskSnapshot task = await reference.putFile(file).whenComplete(() {});
          photoUrl = await task.ref.getDownloadURL();
          print(photoUrl);
        } catch (e) {
          print('Error uploading photo: $e');
          return;
        }
      }

      try {
        final response = await http.post(
          Uri.parse("https://api.airtable.com/v0/app7TDeHagnJEtYlz/Details"),
          headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer pat703vpKB5Wlg35B.20b7f83d25dcae00c8fb81f71c5c932c1a00a9c32138dc83c206f5e09f82f135",
          },
          body: json.encode({
            "fields": {
              "First Name": _firstNameController.text,
              "Last Name": _lastNameController.text,
              "Designation": _designationController.text,
              "Github Link": _githubLinkController.text,
              "Email": _emailController.text,
              "DOB": _dobController.text,
              "Address": _addressController.text,
              "Phone": _phoneController.text,
              "College Name": _collegeNameController.text,
              "Degree Name": _degreeNameController.text,
              "Education City": _educationCityController.text,
              "Job Title": _jobtitleController.text,
              "Job Description": _jobDescriptionController.text,
              "Organization": _organizationController.text,
              "Job City": _jobCityController.text,
              "Summary": _summaryController.text,
              "Hobbies": _hobbiesController.text,
              "Languages": _languagesController.text
                  .split(',')
                  .map((e) => e.trim())
                  .toList(),
              "Photo": photoUrl,
            },
          }),
        );
        print(response.statusCode);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('CV saved successfully!')),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // Pick image from camera or gallery
  Future<void> getPhoto(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.status;
      if (status.isDenied || status.isPermanentlyDenied) {
        status = await Permission.camera.request();
      }
    }

    if (await Permission.camera.isGranted) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _pickedImage = pickedFile;
          _photoController.text = pickedFile.path;
        });
      }
    }
  }

  // Show picker for selecting image
  void _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  getPhoto(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getPhoto(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when no longer needed
    _firstNameController.dispose();
    _lastNameController.dispose();
    _designationController.dispose();
    _githubLinkController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _collegeNameController.dispose();
    _degreeNameController.dispose();
    _educationCityController.dispose();
    _jobtitleController.dispose();
    _jobDescriptionController.dispose();
    _organizationController.dispose();
    _jobCityController.dispose();
    _summaryController.dispose();
    _hobbiesController.dispose();
    _languagesController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 17.0, right: 17.0, top: 17.0),
              child: Column(
                children: [
                  const Text(
                    'CV FORM',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 120.0, right: 120.0),
                    child: Divider(
                      height: 0,
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'First Name*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your first name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                        labelText: 'Last Name*', border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your last name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _designationController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.school_sharp),
                        labelText: 'Designation',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _githubLinkController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.link),
                        labelText: 'Github Link',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email id.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _dobController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        labelText: 'Date of Birth*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your date of birth.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        labelText: 'Address*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your address.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.call),
                        labelText: 'Phone*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your phone number.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _collegeNameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.school),
                        labelText: 'College Name*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your college name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _degreeNameController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.school),
                        labelText: 'Degree Name*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your degree name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _educationCityController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        labelText: 'Education City*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your education city name.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _jobtitleController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.work),
                        labelText: 'Job Title',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _jobDescriptionController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.work_history),
                        labelText: 'Job Description',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _organizationController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_4),
                        labelText: 'Organization',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _jobCityController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        labelText: 'Job City',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _summaryController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        labelText: 'Summary*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fillup summary field.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _hobbiesController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.games),
                        labelText: 'Hobbies*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your hobbies.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _languagesController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.language),
                        labelText: 'Languages*',
                        border: OutlineInputBorder()),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your languages.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Stack(
                    children: [
                      TextFormField(
                        readOnly: true,
                        controller: _photoController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.camera),
                            labelText: 'Photo*',
                            border: OutlineInputBorder()),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please upload your photo";
                          }
                          return null;
                        },
                        onTap: () => _showPicker(context: context),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt),
                          onPressed: () => _showPicker(context: context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black)),
                    onPressed: () {
                      _submitForm();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
