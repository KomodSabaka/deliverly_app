import 'dart:io';

import 'package:deliverly_app/utils/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void showSnakeBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: backgroundColorSelectModePage,
      content: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: backdropColor),
      ),
    ),
  );
}

Widget disableIndicator({required Widget child}) {
 return NotificationListener<OverscrollIndicatorNotification>(
    onNotification: (overScroll) {
      overScroll.disallowIndicator();
      return true;
    },
    child: child,
  );
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnakeBar(context, e.toString());
  }
  return image;
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

Future<String> storeFileToFirebase(String ref, File file) async {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

void deleteImageFromStorageFirebase(String url) async {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  await firebaseStorage.refFromURL(url).delete();
}
