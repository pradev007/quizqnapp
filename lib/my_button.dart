import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyButton extends StatelessWidget {
  final List<TextEditingController> controllers;
  const MyButton({super.key, required this.controllers});

  void clearText() {
    for (var controller in controllers) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50.0,
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
          // onPressed: widget.controller.clear,
          onPressed: () {
            final snackBar = SnackBar(
                // showCloseIcon: true,
                content: const Text(
                  'All Cleared',
                  style: TextStyle(fontSize: 20.0),
                ),
                backgroundColor: Colors.blueGrey[400],
                duration: const Duration(seconds: 1),
                behavior: SnackBarBehavior.floating,
                // margin: const EdgeInsets.only(bottom: 100.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            clearText();
          },

          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF52D8A0))),
          child: const Text(
            'Clear All',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
