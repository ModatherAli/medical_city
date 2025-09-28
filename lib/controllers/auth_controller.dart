import 'package:get/get.dart';
import 'package:medical_city/models/user_model.dart';
import 'package:medical_city/services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  UserModel? get user => _user.value;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString verificationId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    isLoading.value = true;
    final result = await _authService.checkAuthStatus();
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        _user.value = null;
      },
      (userModel) {
        _user.value = userModel;
      },
    );
    isLoading.value = false;
  }

  Future<void> signUpWithEmail(String email, String password, String name) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _authService.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        _user.value = null;
      },
      (userModel) {
        _user.value = userModel;
      },
    );
    isLoading.value = false;
  }

  Future<void> signInWithEmail(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _authService.signInWithEmail(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        _user.value = null;
      },
      (userModel) {
        _user.value = userModel;
      },
    );
    isLoading.value = false;
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    await _authService.resetPassword(email: email);
    isLoading.value = false;
  }

  Future<void> logout() async {
    isLoading.value = true;
    await _authService.logout();
    _user.value = null;
    isLoading.value = false;
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _authService.verifyPhoneNumber(phoneNumber);
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (id) {
        verificationId.value = id;
      },
    );
    isLoading.value = false;
  }

  Future<void> verifyPhoneCode(String smsCode) async {
    isLoading.value = true;
    errorMessage.value = '';
    final result = await _authService.verifyPhoneCode(verificationId.value, smsCode);
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (userModel) {
        _user.value = userModel;
      },
    );
    isLoading.value = false;
  }
}