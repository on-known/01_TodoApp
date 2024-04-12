import 'package:flutter/material.dart';

class DiologueBOx extends StatelessWidget {
  const DiologueBOx({super.key, required this.controller , required this.onCancel , required this.onSave});

  final TextEditingController controller;

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: MediaQuery.of(context).size.height * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a New Task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Buttons(onPressed: onSave, title: "Save"),
                const SizedBox(
                  width: 20,
                ),
                Buttons(onPressed: onCancel, title: "Cancel")
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({super.key, required this.onPressed, required this.title});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(title),
    );
  }
}
