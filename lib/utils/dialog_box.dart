import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Get User Input
            TextField(
              controller: controller, // Bind the controller to the TextField
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: ("Enter the New Task"),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
              ),
            ),

            // Buttons: Save and Cancel
            Row(
              children: [
                // Save Button
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(
                  width: 25,
                ),

                // Cancel Button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
