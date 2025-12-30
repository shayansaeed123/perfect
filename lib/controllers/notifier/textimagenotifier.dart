

import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
// import 'package:cropper/cropper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:project/controllers/color_controller.dart';
// import 'package:project/models/textimagemodel.dart';

// class ImageTextNotifier extends StateNotifier<ImageTextState> {
//   ImageTextNotifier() : super(ImageTextState());

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImageAndExtractText() async {
//     try {
//       state = state.copyWith(isLoading: true);

//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image == null) {
//         state = state.copyWith(isLoading: false);
//         return;
//       }
       
       
//       final CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: image.path,
//         uiSettings: [
//     AndroidUiSettings(
//       toolbarTitle: 'Crop Image',
//       toolbarColor: colorController.mainColor,
//       toolbarWidgetColor: colorController.whiteColor,
//       lockAspectRatio: false,
//       initAspectRatio: CropAspectRatioPreset.original,
//       // add padding / margin if supported
//       cropFrameStrokeWidth: 3,
//       cropGridStrokeWidth: 2,
//       // maybe force toolbar height
//       hideBottomControls: false,
//       showCropGrid: true,
//       // possibly hiddenControls: false, showCropGrid: true etc
//     ),
//     IOSUiSettings(
//       title: 'Crop Image',
//       // iOS specific tweaks
//     ),
//   ],
//       );

//       // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//        // Restore system UI overlays
//     // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); 
    
//       if (croppedFile == null) {
//         state = state.copyWith(isLoading: false);
//         return;
//       }

//       final file = File(croppedFile.path);

//       final inputImage = InputImage.fromFile(file);
//       final textRecognizer =
//           TextRecognizer(script: TextRecognitionScript.latin);

//       final RecognizedText recognizedText =
//           await textRecognizer.processImage(inputImage);

//       await textRecognizer.close();

//       state = state.copyWith(
//         image: file,
//         extractedText: recognizedText.text.isNotEmpty
//             ? recognizedText.text
//             : "No text found in cropped area",
//         isLoading: false,
//       );
//     } catch (e) {
//       state = state.copyWith(isLoading: false, extractedText: "Error: $e");
//     }
//   }
// }

// final imageTextProvider =
//     StateNotifierProvider<ImageTextNotifier, ImageTextState>(
//   (ref) => ImageTextNotifier(),
// );



import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/models/textimagemodel.dart';


enum OcrTarget {plateNo,vin,engineNo,}


class ImageTextNotifier extends StateNotifier<ImageTextState> {
  ImageTextNotifier() : super(ImageTextState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageAndExtractText(
      BuildContext context,
      OcrTarget target,
      ImageSource source,
      ) async {
    try {
      state = state.copyWith(isLoading: true);

      /// 📷 Capture image
      final XFile? image = await _picker.pickImage(source: source);

      if (image == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      /// ✂️ Custom crop screen
      final File? croppedFile = await Navigator.push<File>(
        context,
        MaterialPageRoute(
          builder: (_) => CropScreen(imageFile: File(image.path)),
        ),
      );

      if (croppedFile == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      /// 🔍 OCR
      final inputImage = InputImage.fromFile(croppedFile);
      final textRecognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

      final RecognizedText recognizedText =
      await textRecognizer.processImage(inputImage);

      await textRecognizer.close();

      final extractedText = recognizedText.text.trim().isNotEmpty
          ? recognizedText.text.trim()
          : "No text found in cropped area";

      /// 🎯 Assign to correct field
      if (target == OcrTarget.plateNo) {
        state = state.copyWith(
          image: croppedFile,
          plateNoText: extractedText,
          isLoading: false,
        );
      } else if (target == OcrTarget.vin) {
        state = state.copyWith(
          image: croppedFile,
          vinText: extractedText,
          isLoading: false,
        );
      } else if (target == OcrTarget.engineNo) {
        state = state.copyWith(
          image: croppedFile,
          engineNo: extractedText,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
      );
    }
  }
}


final imageTextProvider =
    StateNotifierProvider<ImageTextNotifier, ImageTextState>(
  (ref) => ImageTextNotifier(),
);





class CropScreen extends StatefulWidget {
  final File imageFile;

  const CropScreen({super.key, required this.imageFile});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final CropController _controller = CropController();
  Uint8List? _imageData;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    _imageData = await widget.imageFile.readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_imageData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Crop(
  controller: _controller,
  image: _imageData!,
  onCropped: (Uint8List croppedData) {
    final file = File(
      '${widget.imageFile.parent.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    file.writeAsBytesSync(croppedData); // ✅ WORKS

    Navigator.pop(context, file);
  },
),





            /// ✅ CHECK BUTTON — BOTTOM CENTER
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: FloatingActionButton(
                  backgroundColor: colorController.mainColor,
                  onPressed: () {
                    _controller.crop();
                  },
                  child: const Icon(Icons.check, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

