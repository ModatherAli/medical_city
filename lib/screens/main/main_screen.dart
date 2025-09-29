import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/controllers.dart';
import 'package:medical_city/screens/main/widgets/dector_card.dart';
import 'package:medical_city/screens/main/widgets/service_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.blue[800]),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_outlined, color: Colors.blue[800]),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined, color: Colors.blue[800]),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            DectorCard(),

            const SizedBox(height: 24),

            // My Medical File Section
            const Text(
              'My Medical File',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // Medical File Grid
            Wrap(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              // crossAxisCount: 4,
              spacing: 12,
              // mainAxisSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ServiceCard(
                  icon: 'assets/icons/Appointments.png',
                  title: 'Appointments',
                ),
                ServiceCard(
                  icon: 'assets/icons/Requests.png',
                  title: 'Requests',
                ),
                ServiceCard(
                  icon: 'assets/icons/Inquiries.png',
                  title: 'Inquiries',
                ),
                ServiceCard(
                  icon: 'assets/icons/InPatient.png',
                  title: 'In Patient',
                ),
                ServiceCard(
                  icon: 'assets/icons/MedicalReports.png',
                  title: 'Medical Reports',
                ),
                ServiceCard(
                  icon: 'assets/icons/Outpatient.png',
                  title: 'Outpatient',
                ),
              ],
            ),

            const SizedBox(height: 32),

            // E-services Section
            const Text(
              'E-services',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            // E-services Grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ServiceCard(icon: 'assets/icons/Book.png', title: 'Book'),
                ServiceCard(
                  icon: 'assets/icons/VirtualCare.png',
                  title: 'Virtual Care',
                ),
                if (userController.currentUser.isAdmin)
                  ServiceCard(
                    onTap: () {
                      context.push(NavigationRoutes.medicalManagement);
                    },
                    icon: 'assets/icons/DoctorManagement.png',
                    title: 'Medical\nManagement',
                  ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
