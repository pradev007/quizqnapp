import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qnquizz/my_button.dart';
import 'package:qnquizz/my_text_form.dart';
import 'package:qnquizz/read_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final questionController = TextEditingController();

  final correctController = TextEditingController();

  final incorrectController1 = TextEditingController();

  final incorrectController2 = TextEditingController();

  final incorrectController3 = TextEditingController();
  //
  final _formKey = GlobalKey<FormState>();
  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return "Empty text field";
    } else {
      return null;
    }
  }

  void _validateForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid
      print('Form is valid');
    } else {
      // Form is invalid
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                // Question text field
                MyTextFormField(
                  text1: 'Question ',
                  maxLine1: 4,
                  controller: questionController,
                  validator: _validateText,
                ),

                const SizedBox(height: 20.0),
                MyTextFormField(
                  text1: 'correct ',
                  maxLine1: 1,
                  controller: correctController,
                  validator: _validateText,
                ),
                MyTextFormField(
                  text1: 'incorrect ',
                  maxLine1: 1,
                  controller: incorrectController1,
                  validator: _validateText,
                ),
                MyTextFormField(
                  text1: 'incorrect ',
                  maxLine1: 1,
                  controller: incorrectController2,
                  validator: _validateText,
                ),
                MyTextFormField(
                  text1: 'incorrect ',
                  maxLine1: 1,
                  controller: incorrectController3,
                  validator: _validateText,
                ),
                const SizedBox(height: 10.0),

                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.0,
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: () {
                        _validateForm();
                        final snackBar = SnackBar(
                            content: const Text(
                              'Submitted',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            backgroundColor: Colors.blueGrey[400],
                            // elevation: 250.0,
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        CollectionReference collRef =
                            FirebaseFirestore.instance.collection('questions');
                        collRef.add({
                          'qn': questionController.text,
                          'correct': correctController.text,
                          'incorrect1': incorrectController1.text,
                          'incorrect2': incorrectController2.text,
                          'incorrect3': incorrectController3.text
                        }).then(
                          (value) {
                            // clear all fields in submittion
                            for (var controller in [
                              questionController,
                              correctController,
                              incorrectController1,
                              incorrectController2,
                              incorrectController3
                            ]) {
                              controller.clear();
                            }
                          },
                        );
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xF6C52626))),
                      child: const Text(
                        'Submit Quiz',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                // button to clear question text field when 'clear question' button is pressed
                MyButton(
                  controllers: [
                    questionController,
                    correctController,
                    incorrectController1,
                    incorrectController2,
                    incorrectController3,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50.0,
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReadData()));
                      },
                      style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Color.fromARGB(255, 18, 83, 62))),
                      child: const Text(
                        'Get Qn',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
