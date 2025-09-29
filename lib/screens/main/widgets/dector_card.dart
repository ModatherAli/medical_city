import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:medical_city/controllers/user_controller.dart';

class DectorCard extends StatelessWidget {
  const DectorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        var user = userController.currentUser;
        return Card(
          color: Colors.blue[100],
          elevation: 0.5,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dr. ${user.name}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text(
                        'Medical File',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Phone:',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  user.phone,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  'Member since:',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  MaterialLocalizations.of(context).formatFullDate(user.joinAt),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
