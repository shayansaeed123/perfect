import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/repo/utils.dart';
import 'package:project/repo/validation.dart';
import 'package:project/reuse/reusablebottomsheet.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusablecarimages.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:project/views/dashboard/home.dart';
import 'package:project/views/dashboard/navbar.dart';

class Carimages extends ConsumerStatefulWidget {
  const Carimages({super.key});

  @override
  ConsumerState<Carimages> createState() => _CarimagesState();
}

class _CarimagesState extends ConsumerState<Carimages> {
  File? profile_image1;
  File? profile_image2;
  File? profile_image3;
  File? profile_image4;
  File? profile_image5;
  File? profile_image6;
  File? profile_image7;
  File? profile_image8;
  final picker = ImagePicker();

  Future<File> compressImage(File file) async {
  try {
    if (!Platform.isAndroid && !Platform.isIOS) {
      // Web/Desktop fallback
      debugPrint("Compression not supported on this platform");
      return file;
    }

    final dir = await getTemporaryDirectory();
    final targetPath =
        path.join(dir.path, 'temp_${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}');

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
      minWidth: 1080,
      minHeight: 1080,
    );

    return compressedFile != null ? File(compressedFile.path) : file;
  } catch (e) {
    debugPrint('Compression error: $e');
    return file;
  }
}

  Future<void> _pickImage(ImageSource source, String fieldName) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    File selectedImage = File(pickedFile.path);

    if (source == ImageSource.camera) {
      selectedImage = await compressImage(selectedImage);
    }

    if (!mounted) return;

    // Dialog Preview
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Preview Image'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.file(selectedImage, fit: BoxFit.contain),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: reusableBtn(
              context,
              'Cancel',
              () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: reusableBtn(
              context,
              'Submit',
              () async {
               Navigator.pop(context); // close dialog
              Navigator.pop(context);
              
              // ✅ Upload
              final uploadedPath = await ref
                  .read(carFormProvider.notifier)
                  .uploadCarImage(selectedImage, fieldName);

              if (!mounted) return; // <-- check again

              if (uploadedPath != null) {
                setState(() {
                  switch (fieldName) {
                    case 'profile_image1': profile_image1 = selectedImage; break;
                    case 'profile_image2': profile_image2 = selectedImage; break;
                    case 'profile_image3': profile_image3 = selectedImage; break;
                    case 'profile_image4': profile_image4 = selectedImage; break;
                    case 'profile_image5': profile_image5 = selectedImage; break;
                    case 'profile_image6': profile_image6 = selectedImage; break;
                    case 'profile_image7': profile_image7 = selectedImage; break;
                    case 'profile_image8': profile_image8 = selectedImage; break;
                  }
                });

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("❌ Upload failed")),
                );
              }
              },
            ),
          ),
        ],
      ),
    );
  }

  String getImagePath(dynamic image) {
  if (image == null) {
    return "assets/images/addimgplaceholder.png";
  }

  if (image is File) {
    return image.path;
  }

  if (image is String && image.startsWith("http")) {
    return image; // URL
  }

  return "assets/images/addimgplaceholder.png";
}



  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingProvider);
    final editId = ref.watch(editInvoiceIdProvider);
    final form = ref.watch(carFormProvider);
    print(form.profile_image1);
    return Stack(
      children: [
        Center(
        child: Transform.rotate(
          angle: -0.8, // radians me (≈ -30 degree)
          child: Opacity(
            opacity: 0.1, // halka watermark jesa
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            reusablaSizaBox(context, 0.02),
            reusableText('Car Images',color:colorController.textColorDark,fontsize: 18,),
            // reusablaSizaBox(context, 0.03),
            reusableimagewidget(
                  context,
                  'Car Image (Front)',
                  'Car Image (Back)',
                  '',
                  profile_image1?.path ?? 'assets/images/addimgplaceholder.png',
                  profile_image2?.path ?? 'assets/images/addimgplaceholder.png',
                  // getImagePath(profile_image1 ?? form.profile_image1),
                  // getImagePath(profile_image2 ?? form.profile_image2),
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Car Front Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image1'),
                      () => _pickImage(ImageSource.camera, 'profile_image1'),
                    );
                  },
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Car Back Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image2'),
                      () => _pickImage(ImageSource.camera, 'profile_image2'),
                    );
                  },
                  'assets/images/addimgplaceholder.png',
                ),
                // reusablaSizaBox(context, 0.03),
            reusableimagewidget(
                  context,
                  'Clustermeter Image',
                  'Interior Image',
                  '',
                  profile_image3?.path ?? 'assets/images/addimgplaceholder.png',
                  profile_image4?.path ?? 'assets/images/addimgplaceholder.png',
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Clustermeter Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image3'),
                      () => _pickImage(ImageSource.camera, 'profile_image3'),
                    );
                  },
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Interior Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image4'),
                      () => _pickImage(ImageSource.camera, 'profile_image4'),
                    );
                  },
                  'assets/images/addimgplaceholder.png',
                ),
            reusableimagewidget(
                  context,
                  'Chassis/VIN Plate',
                  'MULKIYA/POSSESSION',
                  '',
                  profile_image5?.path ?? 'assets/images/addimgplaceholder.png',
                  profile_image6?.path ?? 'assets/images/addimgplaceholder.png',
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Chassis/VIN Plate Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image5'),
                      () => _pickImage(ImageSource.camera, 'profile_image5'),
                    );
                  },
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose MULKIYA/POSSESSION Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image6'),
                      () => _pickImage(ImageSource.camera, 'profile_image6'),
                    );
                  },
                  'assets/images/addimgplaceholder.png',
                ),
                // reusablaSizaBox(context, 0.03),
            reusableimagewidget(
                  context,
                  'Car Image (Left)',
                  'Car Image (Right)',
                  '',
                  profile_image7?.path ?? 'assets/images/addimgplaceholder.png',
                  profile_image8?.path ?? 'assets/images/addimgplaceholder.png',
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Car Left Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image7'),
                      () => _pickImage(ImageSource.camera, 'profile_image7'),
                    );
                  },
                  () {
                    reuablebottomsheet(
                      context,
                      "Choose Car Right Image",
                      () => _pickImage(ImageSource.gallery, 'profile_image8'),
                      () => _pickImage(ImageSource.camera, 'profile_image8'),
                    );
                  },
                  'assets/images/addimgplaceholder.png',
                ),
                reusablaSizaBox(context, 0.05),
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableBtn(context, 'Back', () {
                  ref.read(progressProvider.notifier).state = 2;
                },width: 0.4),
        //         reusableBtn(context, 'Submit', () async{
        //           final error =
        //               ref.read(carImagesValidationProvider.notifier).validate(
        //                     img1: carForm.profile_image1,
        //                     img2: carForm.profile_image2,
        //                     img3: carForm.profile_image3,
        //                     img4: carForm.profile_image4,
        //                     img5: carForm.profile_image5,
        //                     img6: carForm.profile_image6,
        //                     img7: carForm.profile_image7,
        //                     img8: carForm.profile_image8,
        //                   );
        
        //           if (error != null) {
        //             Utils.snakbar(context, error);
        //             return;
        //           }
        
        //           ref.read(loadingProvider.notifier).state = true;
        //           final resp =
        //               await ref.read(carFormProvider.notifier).submitCarForm();
        //           ref.read(loadingProvider.notifier).state = false;
        
        //           if (resp) {
        // // ✅ Success — Form clear + Navigate to Home
        // ref.read(carFormProvider.notifier).resetForm();
        // reusabletextfieldcontroller.clearAll(); // <-- Controllers clear
        // ref.read(progressProvider.notifier).state = 0; // Back to Customer Page
        
        // if (context.mounted) {
        //   Navigator.pushAndRemoveUntil(
        // context,
        // MaterialPageRoute(builder: (context) => const NavBar()), 
        // (route) => false,);
        // Utils.snakbarSuccess(context, '✅ Form submitted successfully');
        // }
        //   } else {
        // // ❌ Failed
        // if (context.mounted) {
        //   Utils.snakbar(context, "❌ Submission Failed");
        // }
        //   }
        //         },width: 0.4),

        reusableBtn(
  context,
  editId != null ? 'Update' : 'Submit',
  () async {
    final carForm = ref.read(carFormProvider);
    final error = ref.read(carImagesValidationProvider.notifier).validate(
      img1: carForm.profile_image1,
      img2: carForm.profile_image2,
      img3: carForm.profile_image3,
      img4: carForm.profile_image4,
      img5: carForm.profile_image5,
      img6: carForm.profile_image6,
      img7: carForm.profile_image7,
      img8: carForm.profile_image8,
    );

    if (error != null) {
      Utils.snakbar(context, error);
      return;
    }

    ref.read(loadingProvider.notifier).state = true;
    final editId = ref.read(editInvoiceIdProvider);
    bool success = false;

    if (editId != null) {
      // EDIT mode -> use updateInvoice
      success = await ref.read(carFormProvider.notifier).updateInvoice(ref);
      print('object1');
    } else {
      // CREATE mode -> submit new
      success = await ref.read(carFormProvider.notifier).submitCarForm();
      print('object2');
    }

    ref.read(loadingProvider.notifier).state = false;

    if (success) {
      // clear and navigate
      ref.read(carFormProvider.notifier).resetForm();
      reusabletextfieldcontroller.clearAll();
      ref.read(progressProvider.notifier).state = 0;
      ref.read(editInvoiceIdProvider.notifier).state = null;

      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
          (route) => false,
        );
        Utils.snakbarSuccess(context, editId != null ? '✅ Invoice updated successfully' : '✅ Form submitted successfully');
      }
    } else {
      if (context.mounted) Utils.snakbar(context, "❌ Operation failed");
    }
  },
  width: 0.4,
),
              ],
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
        ),
        if (isLoading)
      Container(
        color: Colors.black.withOpacity(0.4),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      ],
    );
  }
}