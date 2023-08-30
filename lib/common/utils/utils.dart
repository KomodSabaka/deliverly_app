import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'constants.dart';

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

void phoneNumberFormat({
  required String value,
  required TextEditingController controller,
}) {
  String phone = value.trim().replaceAll(RegExp("[+., ()\\s-]"), "");

  if (value.endsWith(' ') || value.endsWith('-') || value.endsWith('+')) {
    controller.text = value.substring(0, value.length - 1);
    controller.selection =
        TextSelection.collapsed(offset: controller.text.length);
    return;
  }

  if (phone.length == 1) {
    controller.text = '+$phone';
  }
  if (phone.length == 2) {
    controller.text = '+${phone.substring(0, 1)} ${phone.substring(1, 2)}';
  }
  if (phone.length == 5) {
    controller.text =
        '+${phone.substring(0, 1)} ${phone.substring(1, 4)} ${phone.substring(4, 5)}';
  }
  if (phone.length == 8) {
    controller.text =
        '+${phone.substring(0, 1)} ${phone.substring(1, 4)} ${phone.substring(4, 7)}-${phone.substring(7, 8)}';
  }
  if (phone.length == 10) {
    controller.text =
        '+${phone.substring(0, 1)} ${phone.substring(1, 4)} ${phone.substring(4, 7)}-${phone.substring(7, 9)}-${phone.substring(9, 10)}';
  }

  controller.selection =
      TextSelection.collapsed(offset: controller.text.length);
}
