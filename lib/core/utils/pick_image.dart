import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:the_write_blueprint/core/error/exceptions.dart';

Future<File?> pickAndCompressImage(BuildContext context) async {
  try {
    // Show the dialog to choose between Camera and Gallery
    final ImageSource? source = await showImageSourceDialog(context);

    if (source == null) return null; // User canceled the selection

    final xFile = await ImagePicker().pickImage(source: source);

    if (xFile != null) {
      final file = File(xFile.path);
      final compressedFile = await compressImage(file);
      return compressedFile;
    }

    return null;
  } catch (e) {
    throw Exceptions(e.toString());
  }
}

Future<ImageSource?> showImageSourceDialog(BuildContext context) async {
  return showModalBottomSheet<ImageSource>(
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Gallery'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
        ],
      ),
    ),
  );
}

Future<File> compressImage(File file) async {
  // Read the file as bytes
  final Uint8List bytes = await file.readAsBytes();

  // Decode the image
  final img.Image? image = img.decodeImage(bytes);
  if (image == null) {
    throw Exception("Unable to decode image");
  }

  // Resize the image to a smaller width while maintaining aspect ratio
  final img.Image resizedImage = img.copyResize(image, width: 800);

  // Encode the image to a smaller file with reduced quality
  final List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 85);

  // Save the compressed image to a new file
  final compressedFile =
      File(file.path.replaceFirst('.jpg', '_compressed.jpg'));
  await compressedFile.writeAsBytes(compressedBytes);

  return compressedFile;
}
