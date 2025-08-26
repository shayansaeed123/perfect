

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/reuse/reusablebottomsheet.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusablecarimages.dart';
import 'package:project/reuse/reusabletext.dart';

class Carimages extends ConsumerStatefulWidget {
  const Carimages({super.key});

  @override
  ConsumerState<Carimages> createState() => _CarimagesState();
}

class _CarimagesState extends ConsumerState<Carimages> {
  File? _carFront;
  File? _carBack;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source, String imageType) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    File selectedImage = File(pickedFile.path);

    // Convert to base64
    final bytes = await selectedImage.readAsBytes();
    final base64Image = base64Encode(bytes);

    setState(() {
      if (imageType == 'front') {
        _carFront = selectedImage;
        ref.read(carFormProvider.notifier).updateCarImages(front: base64Image);
      } else {
        _carBack = selectedImage;
        ref.read(carFormProvider.notifier).updateCarImages(back: base64Image);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(carFormProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        reusablaSizaBox(context, 0.02),
        reusableText('Customer Details',color:colorController.textColorDark,fontsize: 18,),
        reusablaSizaBox(context, 0.03),
        reusableimagewidget(
              context,
              'Add Image (Front)',
              'Add Image (Back)',
              'Car Images',
              _carFront?.path ?? 'assets/images/addimgplaceholder.png',
              _carBack?.path ?? 'assets/images/addimgplaceholder.png',
              () {
                reuablebottomsheet(
                  context,
                  "Choose Car Front Image",
                  () => _pickImage(ImageSource.gallery, 'front'),
                  () => _pickImage(ImageSource.camera, 'front'),
                );
              },
              () {
                reuablebottomsheet(
                  context,
                  "Choose Car Back Image",
                  () => _pickImage(ImageSource.gallery, 'back'),
                  () => _pickImage(ImageSource.camera, 'back'),
                );
              },
              'assets/images/addimgplaceholder.png',
            ),
        // reusableimagewidget(
        //       context,
        //       'Add Image (Front)',
        //       'Add Image (Back)',
        //       'Car Images',
        //       formData.carFrontImage ?? 'assets/images/add_img_placeholder.png',
        //       formData.carBackImage ?? 'assets/images/add_img_placeholder.png',
        //       () {
        //         reuablebottomsheet(
        //           context,
        //           "Choose Car Front Image",
        //           () => _pickImage(ImageSource.gallery, 'front'),
        //           () => _pickImage(ImageSource.camera, 'front'),
        //         );
        //       },
        //       () {
        //         reuablebottomsheet(
        //           context,
        //           "Choose Car Back Image",
        //           () => _pickImage(ImageSource.gallery, 'back'),
        //           () => _pickImage(ImageSource.camera, 'back'),
        //         );
        //       },
        //       'assets/images/add_img_placeholder.png',
        //     ),
      ],
    );
  }
}