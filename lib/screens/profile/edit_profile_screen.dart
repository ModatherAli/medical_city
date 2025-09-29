import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_city/app/router/navigation_routes.dart';
import 'package:medical_city/controllers/user_controller.dart';
import 'package:medical_city/models/user_model.dart';
import 'package:medical_city/screens/widgets/beauty_text_field.dart';
import 'package:medical_city/services/firebase/fire_storage.dart';
import 'package:medical_city/shared/validators/form_validators.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  DateTime? _birthDate;

  final userController = Get.find<UserController>();
  late UserModel _currentUser;
  @override
  void initState() {
    super.initState();
    _currentUser = userController.currentUser;
    _name.text = _currentUser.name;
    _email.text = _currentUser.email;
    _birthDate = _currentUser.birthDate;
    _phone.text = FirebaseAuth.instance.currentUser!.phoneNumber ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete your profile'.tr)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const SizedBox(height: 8),
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _pickedImage != null
                        ? Image.file(
                            File(_pickedImage!.path),
                            fit: BoxFit.cover,
                          ).image
                        : _currentUser.imageUrl.isNotEmpty
                        ? Image.network(_currentUser.imageUrl).image
                        : null,
                    child: _pickedImage == null && _currentUser.imageUrl.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _pickImage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            BeautyTextField(
              fieldName: 'Full name',
              controller: _name,
              validator: minLengthValidator(3),
            ),
            BeautyTextField(
              fieldName: 'Email',
              controller: _email,
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
            ),
            BeautyTextField(
              fieldName: 'Phone number',
              enabled: false,
              controller: _phone,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _pickBirthDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Birth date'.tr,
                  border: const OutlineInputBorder(),
                ),
                child: Text(
                  _birthDate != null
                      ? MaterialLocalizations.of(
                          context,
                        ).formatFullDate(_birthDate!)
                      : 'Select birth date'.tr,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: FilledButton(onPressed: _onSave, child: Text('Save'.tr)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;
    final controller = Get.find<UserController>();
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    String imageUrl = controller.currentUser.imageUrl;
    if (_pickedImage != null) {
      final uploadedUrl = await FireStorage.loadFileToFireStorage_(
        localFilePath: _pickedImage!.path,
        folderName: 'users',
        name: firebaseUser.uid,
      );
      if (uploadedUrl != null) {
        imageUrl = uploadedUrl;
      }
    }

    final user = UserModel(
      id: firebaseUser.uid,
      name: _name.text.trim(),
      email: _email.text.trim(),
      phone: firebaseUser.phoneNumber ?? '',
      imageUrl: imageUrl,
      joinAt: controller.currentUser.joinAt == DateTime(0)
          ? DateTime.now()
          : (controller.currentUser.joinAt),
      birthDate: _birthDate ?? DateTime.now(),
    );
    final saved = await controller.saveUserData(user);
    if (!mounted) return;
    if (saved) {
      context.go(NavigationRoutes.bottomNavBar);
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Future<void> _pickBirthDate() async {
    final DateTime now = DateTime.now();
    final DateTime first = DateTime(now.year - 100, now.month, now.day);
    final DateTime last = DateTime(now.year, now.month, now.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(now.year - 20, now.month, now.day),
      firstDate: first,
      lastDate: last,
    );
    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }
}
