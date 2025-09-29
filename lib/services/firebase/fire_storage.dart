// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

// import '../logger.dart';

// class FireStorage {
//   static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   // static Future<List<String>> loadMultiFileToFireStorage({
//   //   required List<String> filesPath,
//   //   required String folderName,
//   // }) async {
//   //   List<String> urls = [];

//   //   for (var path in filesPath) {
//   //     String? url = await loadFileToFireStorage(
//   //       localFilePath: path,
//   //       folderName: folderName,
//   //     );
//   //     if (url != null) {
//   //       urls.add(url);
//   //     }
//   //   }

//   //   return urls;
//   // }

//   static Future<String?> loadFileToFireStorage_({
//     required String localFilePath,
//     required String folderName,
//     String? name,
//   }) async {
//     String loadedFileUrl = '';

//     try {
//       File file = File(localFilePath);
//       String fileName =
//           'image-${DateTime.now().millisecondsSinceEpoch}-${basename(file.path)}';

//       Reference storageRef = _firebaseStorage
//           .ref(folderName)
//           .child(name ?? fileName);

//       await storageRef.putFile(file);
//       loadedFileUrl = await storageRef.getDownloadURL();
//       return loadedFileUrl;
//     } catch (e) {
//       Logger.print('load file error $e');
//       return null;
//     }
//   }

//   static Future<bool> deleteFileFromFireStorage({
//     String? fileURL,
//     String? filePath = '',
//   }) async {
//     try {
//       if (fileURL != null) {
//         await _firebaseStorage.refFromURL(fileURL).delete();
//       } else {
//         await _firebaseStorage.ref(filePath).delete();
//       }

//       return true;
//     } catch (e) {
//       Logger.print('Error in delete file: $e');

//       return false;
//     }
//   }

//   static Future<List<FullMetadata>> getFilesMetaData({
//     required List<String> fileURLs,
//   }) async {
//     List<FullMetadata> metadata = [];
//     try {
//       List<Reference> refs = [];
//       for (var fileURL in fileURLs) {
//         refs.add(_firebaseStorage.refFromURL(fileURL));
//       }
//       metadata = await Future.wait(refs.map((ref) => ref.getMetadata()));
//       Logger.print(metadata.length);
//     } catch (e) {
//       Logger.print('Error in get metadata of file: $e');
//     }
//     return metadata;
//   }
// }
