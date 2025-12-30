

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/controllers/color_controller.dart';




reuablebottomsheet(BuildContext context, String title, Function gallaryontap,
    Function cameraontap) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.32,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("$title".toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorController.btnColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'tutorPhi'
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      gallaryontap();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.photo,
                          color: colorController.btnColor,
                          size: 70,
                        ),
                        Text("Gallery",
                            style: TextStyle(
                                color: colorController.btnColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    )),
                InkWell(
                    onTap: () {
                      cameraontap();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.camera,
                          color: colorController.btnColor,
                          size: 70,
                        ),
                        Text("Camera",
                            style: TextStyle(
                                color: colorController.btnColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ],
                    ))
              ],
            ),
          ],
        ),
      );
    },
  );
}




void openBottomSheet(BuildContext context,VoidCallback ontapCamera, VoidCallback ontapGallery) {
    showCupertinoModalBottomSheet(
      context: context,
      topRadius: const Radius.circular(24),
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag Handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                _PickerTile(
                  icon: Icons.camera_alt_rounded,
                  title: 'Camera',
                  subtitle: 'Take a photo',
                  onTap: () {
                    ontapCamera();
                    Navigator.pop(context);
                    debugPrint('Camera selected');
                  },
                ),

                const SizedBox(height: 12),

                _PickerTile(
                  icon: Icons.photo_library_rounded,
                  title: 'Gallery',
                  subtitle: 'Choose from gallery',
                  onTap: () {
                    ontapGallery();
                    Navigator.pop(context);
                    debugPrint('Gallery selected');
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }


  class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PickerTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorController.mainColorWithOpacity,
                ),
                child: Icon(
                  icon,
                  color: colorController.iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
