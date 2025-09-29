

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/models/textimagemodel.dart';

class ImageTextNotifier extends StateNotifier<ImageTextState> {
  ImageTextNotifier() : super(ImageTextState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageAndExtractText() async {
    try {
      state = state.copyWith(isLoading: true);

      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        state = state.copyWith(isLoading: false);
        return;
      }
       await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
       
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        uiSettings: [
    AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: colorController.mainColor,
      toolbarWidgetColor: colorController.whiteColor,
      lockAspectRatio: false,
      initAspectRatio: CropAspectRatioPreset.original,
      // add padding / margin if supported
      cropFrameStrokeWidth: 3,
      cropGridStrokeWidth: 2,
      // maybe force toolbar height
      hideBottomControls: false,
      // possibly hiddenControls: false, showCropGrid: true etc
    ),
    IOSUiSettings(
      title: 'Crop Image',
      // iOS specific tweaks
    ),
  ],
      );

       // Restore system UI overlays
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); 
    
      if (croppedFile == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final file = File(croppedFile.path);

      final inputImage = InputImage.fromFile(file);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);

      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      await textRecognizer.close();

      state = state.copyWith(
        image: file,
        extractedText: recognizedText.text.isNotEmpty
            ? recognizedText.text
            : "No text found in cropped area",
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, extractedText: "Error: $e");
    }
  }
}

final imageTextProvider =
    StateNotifierProvider<ImageTextNotifier, ImageTextState>(
  (ref) => ImageTextNotifier(),
);