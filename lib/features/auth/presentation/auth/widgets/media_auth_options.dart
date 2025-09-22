// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';

// import '../../../controllers/client_controller.dart';
// import '../../../data/modules/modules.dart';
// import '../../../data/services/services.dart';
// import '../../redirect/redirect_screen.dart';
// import 'media_auth_button.dart';

// class MediaAuthOptions extends StatelessWidget {
//   const MediaAuthOptions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ClientController>(builder: (clientController) {
//       return Column(
//         children: [
//           Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.all(14),
//             child: Text(
//               'Register via'.tr,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               MediaAuthButton(
//                 color: Colors.red,
//                 iconData: FontAwesomeIcons.google,
//                 onTap: () async {
//                   await EasyLoading.show(
//                     status: 'In Progress...'.tr,
//                     dismissOnTap: false,
//                   );
//                   bool isSigned = await Auth.signInWithGoogle();
//                   if (isSigned) {
//                     bool isExistsUser = await FirebaseDatabase.isExistsUser();

//                     if (isExistsUser) {
//                       // await clientController.loadData();
//                     } else {
//                       User user = FirebaseAuth.instance.currentUser!;
//                       Client savedClient = Client(
//                         id: user.uid,
//                         name: user.displayName.toString(),
//                         email: user.email.toString(),
//                         phone: user.phoneNumber ?? '',
//                         joinDate: DateTime.now(),
//                         address: emptyAddress,
//                       );

//                       await clientController.updateClientInfo(savedClient);
//                     }
//                     await EasyLoading.dismiss();
//                     Get.offAll(() => const RedirectScreen());
//                   } else {
//                     EasyLoading.showError('an error occurred!'.tr,
//                         dismissOnTap: true);
//                   }
//                 },
//               ),
//               // MediaAuthButton(
//               //   color: Colors.black,
//               //   iconData: Icons.apple,
//               //   onTap: () {
//               //     Get.offAll(() => const HomeScreen());
//               //   },
//               // ),
//               // MediaAuthButton(
//               //   color: Colors.blue,
//               //   iconData: FontAwesomeIcons.twitter,
//               //   onTap: () {},
//               // ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
