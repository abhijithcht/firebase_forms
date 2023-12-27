import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_forms/formfield.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();

  Future<void> addForm() async {
    if (formKey.currentState!.validate()) {
      String user = name.text;
      String email = mail.text;
      String mobile = phone.text;
      String street = address.text;
      String area = city.text;

      await FirebaseFirestore.instance.collection('form').add({
        'user': user,
        'email': email,
        'mobile': mobile,
        'street': street,
        'area': area,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextInputField(
              controller: name,
              hintText: 'Name',
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value.isEmpty || value == null) {
                  return 'Please enter your Name';
                }
              },
            ),
            CustomTextInputField(
                controller: mail,
                prefixIcon: Icons.mail,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return 'Please enter your Email Address';
                  }
                }),
            CustomTextInputField(
                controller: phone,
                prefixIcon: Icons.phone,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return 'Please enter your Phone Number';
                  }
                }),
            CustomTextInputField(
                controller: address,
                hintText: 'Street Address',
                prefixIcon: Icons.streetview,
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return 'Please enter your Street Address';
                  }
                }),
            CustomTextInputField(
                controller: city,
                hintText: 'City',
                prefixIcon: Icons.location_city,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty || value == null) {
                    return 'Please enter your City';
                  }
                }),
            ElevatedButton(
              onPressed: addForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
