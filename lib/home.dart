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
            ),
            CustomTextInputField(
              controller: mail,
              prefixIcon: Icons.mail,
              hintText: 'Email Address',
            ),
            CustomTextInputField(
              controller: phone,
              prefixIcon: Icons.phone,
              hintText: 'Phone Number',
            ),
            CustomTextInputField(
              controller: address,
              hintText: 'Street Address',
              prefixIcon: Icons.streetview,
            ),
            CustomTextInputField(
              controller: city,
              hintText: 'City',
              prefixIcon: Icons.location_city,
            ),
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
