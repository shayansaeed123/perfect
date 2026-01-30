import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/notifier/carfoamnotifier.dart';
import 'package:project/controllers/notifier/invoicenotifier.dart';
import 'package:project/controllers/notifier/loginnotifier.dart';
import 'package:project/controllers/notifier/progressnotifier.dart';
import 'package:project/controllers/notifier/textimagenotifier.dart';
import 'package:project/controllers/textfieldcontrollers.dart';
import 'package:project/repo/utils.dart';
import 'package:project/repo/validation.dart';
import 'package:project/reuse/animationdialog.dart';
import 'package:project/reuse/reusablaimage.dart';
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

    final File? croppedImage = await Navigator.push<File>(
        context,
        MaterialPageRoute(
          builder: (_) => CropScreen(imageFile: selectedImage),
        ),
      );
    // final croppedImage = await cropImage(selectedImage);
    if (croppedImage == null) return;

    if (!mounted) return;

    // Dialog Preview
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Preview Image'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.file(croppedImage, fit: BoxFit.contain),
        ),
        actions: [
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
                  .uploadCarImage(croppedImage, fieldName);

              if (!mounted) return; // <-- check again

              if (uploadedPath != null) {
                setState(() {
                  switch (fieldName) {
                    case 'profile_image1': profile_image1 = croppedImage; break;
                    case 'profile_image2': profile_image2 = croppedImage; break;
                    case 'profile_image3': profile_image3 = croppedImage; break;
                    case 'profile_image4': profile_image4 = croppedImage; break;
                    case 'profile_image5': profile_image5 = croppedImage; break;
                    case 'profile_image6': profile_image6 = croppedImage; break;
                    case 'profile_image7': profile_image7 = croppedImage; break;
                    case 'profile_image8': profile_image8 = croppedImage; break;
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
          Padding(
            padding: const EdgeInsets.all(5),
            child: reusableBtn(
              context,
              'Cancel',
              () => Navigator.of(context).pop(),
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

  if (image is File) return image.path;

  if (image is String && image.startsWith("http")) {
    return image; // URL
  }

  return "assets/images/addimgplaceholder.png";
}




  @override
  Widget build(BuildContext context) {
     debugPrint('🚀 Car Images Screen build called');
    final isLoading = ref.watch(loadingProvider);
    final editId = ref.watch(editInvoiceIdProvider);
    final form = ref.watch(carFormProvider);
    print(form.profile_image1);
    return 
    // Scaffold(
    //   body: 
      Stack(
        children: [
          Positioned.fill(
        child: IgnorePointer(
          child: Center(
            child: Transform.rotate(
              angle: -0.8,
              child: Opacity(
                opacity: 0.08,
                child: Image.asset(
                  "assets/images/logo.png",
                  width: MediaQuery.of(context).size.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                reusableText('Car Images',color:colorController.textColorDark,fontsize: 18,),
                reusablaSizaBox(context, 0.015),
                reusableimagewidget(
                  context,
                  'Car Image (Front)',
                  'Car Image (Back)',
                  // profile_image1?.path ?? 'assets/images/addimgplaceholder.png',
                  // profile_image2?.path ?? 'assets/images/addimgplaceholder.png',
                  getImagePath(profile_image1 ?? form.profile_image1),
                  getImagePath(profile_image2 ?? form.profile_image2),
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

                reusableimagewidget(
                      context,
                      'Car Image (Left)',
                      'Car Image (Right)',
                      // profile_image7?.path ?? 'assets/images/addimgplaceholder.png',
                      // profile_image8?.path ?? 'assets/images/addimgplaceholder.png',
                      getImagePath(profile_image7 ?? form.profile_image7),
                      getImagePath(profile_image8 ?? form.profile_image8),
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
                // reusablaSizaBox(context, 0.03),
                            reusableimagewidget(
                  context,
                  'Clustermeter Image',
                  'Interior Image',
                  // profile_image3?.path ?? 'assets/images/addimgplaceholder.png',
                  // profile_image4?.path ?? 'assets/images/addimgplaceholder.png',
                  getImagePath(profile_image3 ?? form.profile_image3),
                  getImagePath(profile_image4 ?? form.profile_image4),
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
                      // profile_image5?.path ?? 'assets/images/addimgplaceholder.png',
                      // profile_image6?.path ?? 'assets/images/addimgplaceholder.png',
                      getImagePath(profile_image5 ?? form.profile_image5),
                      getImagePath(profile_image6 ?? form.profile_image6),
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
                      
                    reusablaSizaBox(context, 0.02),
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
              isLoading ? null : 
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
                  // ref.read(carFormProvider.notifier).resetForm();
                  // reusabletextfieldcontroller.clearAll();
                  // ref.read(progressProvider.notifier).state = 0;
                  // ref.read(editInvoiceIdProvider.notifier).state = null;
                  
                  if (context.mounted) {
                    
                    // Utils.snakbarSuccess(context, editId != null ? '✅ Invoice updated successfully' : '✅ Form submitted successfully');
                    // showLottieDialog(context, 'assets/images/submit.json', editId != null ? 'Invoice updated successfully' : 'Form submitted successfully', (){
                    //   ref.read(bottomNavProvider.notifier).state = 0;
                    //   Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const NavBar()),
                    //   (route) => false,
                    // );
                    // });
                    showLottieDialog(
  context,
  'assets/images/submit.json',
  editId != null
      ? 'Lead has been successfully updated'
      : 'Lead has been successfully created',
  () {

    // 1️⃣ HOME tab force
    ref.read(bottomNavProvider.notifier).state = 0;

    // 2️⃣ REAL navigation (ROOT navigator)
    Navigator.of(context, rootNavigator: true)
        .pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const NavBar()),
      (route) => false,
    );

    // 3️⃣ AB form reset karo (after navigation)
    Future.microtask(() {
      ref.read(carFormProvider.notifier).resetForm();
      reusabletextfieldcontroller.clearAll();
      ref.read(progressProvider.notifier).state = 0;
      ref.read(editInvoiceIdProvider.notifier).state = null;
    });
  },
);

                  }
                } else {
                  if (context.mounted) Utils.snakbar(context, "❌ Operation failed");
                }
              },
              width: 0.4,
            ),
                  ],
                ),
                reusablaSizaBox(context, 0.02),
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
          ),
          //  / 🔥 PERFECT FULL-SCREEN LOADER
        if (isLoading)
          Positioned.fill(
            child: AbsorbPointer(
              absorbing: true,
              child: Container(
                color: Colors.black.withOpacity(0.55),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
        ],
      // ),
    );
  }
}
