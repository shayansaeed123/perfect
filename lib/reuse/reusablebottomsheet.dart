

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/controllers/keyboardcontroller.dart';
import 'package:project/controllers/notifier/emailnotifier.dart';
import 'package:project/repo/utils.dart';
import 'package:project/reuse/animationdialog.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';




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




void openBottomSheet(BuildContext context,WidgetRef ref,VoidCallback ontapCamera, VoidCallback ontapGallery) {
   ref.read(keyboardControllerProvider).hide(); 
    Future.delayed(Duration(milliseconds: 120), (){
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
    });
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





void openResendCertificateBottomSheet(
  BuildContext context,
  String code,
  String paid,
  WidgetRef ref, {
  required String requestForEmail,
  required String customerEmail,
}) {
  /// 🔹 API se aane wali emails
  final List<String> initialEmails = [];

  if (requestForEmail.isNotEmpty) {
    initialEmails.add(requestForEmail);
  }

  if (customerEmail.isNotEmpty &&
      customerEmail != requestForEmail) {
    initialEmails.add(customerEmail);
  }

  /// 🔹 Provider me set karo
  ref
      .read(resendCertificateProvider.notifier)
      .setEmailsFromApi(initialEmails);

  /// 🔹 Open Bottom Sheet
  showCupertinoModalBottomSheet(
    context: context,
    topRadius: const Radius.circular(20),
    backgroundColor: Colors.white,
    builder: (_) => ResendCertificateSheet(code: code,paid: paid,),
  );
}



class ResendCertificateSheet extends ConsumerWidget {
  String code;
  String paid;
  ResendCertificateSheet({super.key,required this.code,required this.paid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emails = ref.watch(resendCertificateProvider);

    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              /// 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reusableText('Resend Certificate',color: colorController.mainColor),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:  Icon(Icons.close,color: colorController.mainColor,),
                  )
                ],
              ),
      
              reusablaSizaBox(context, 0.03),
      
              /// 🔹 Email List + Add Button
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...List.generate(
                    emails.length,
                    (index) => EmailChip(
                      email: emails[index],
                      onRemove: () {
                        ref
                            .read(resendCertificateProvider.notifier)
                            .removeEmail(index);
                      },
                    ),
                  ),
      
                  /// ➕ Add Email
                  GestureDetector(
                    onTap: () async {
                      final email = await showDialog<String>(
                        context: context,
                        builder: (_) => const AddEmailDialog(),
                      );
      
                      if (email != null && email.isNotEmpty) {
                        ref
                            .read(resendCertificateProvider.notifier)
                            .addEmail(email);
                      }
                    },
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      width: MediaQuery.sizeOf(context).height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorController.mainColor),
                      ),
                      child: Icon(Icons.add, color: colorController.mainColor),
                    ),
                  ),
                ],
              ),
      
              reusablaSizaBox(context, 0.03),
      
              // reusableBtn(context, 'Resend', emails.isEmpty
              //         ? null
              //         : () {
              //             debugPrint('Emails to resend: $emails');
              //             Navigator.pop(context);
              //           },),

              reusableBtn(
                context,
                'Resend',
                emails.isEmpty
                    ? null
                    : () async {
                        try {
                          final apiMessage = await ref
                              .read(resendCertificateProvider.notifier)
                              .resendCertificate(
                                code: code,
                                paid: paid,
                              );


                          /// ✅ Success Message from API
                          // Utils.snakbarSuccess(context, apiMessage);
                          showLottieDialog(context, 'assets/images/email.json', 'email send successfully', (){
                            Navigator.pop(context);
                          });

                        } catch (errorMessage) {

                          /// ❌ Error Message from API
                          Utils.snakbar(context, errorMessage.toString());
                        }
                      },
              )
            ],
          ),
        ),
      ),
    );
  }
}



class EmailChip extends StatelessWidget {
  final String email;
  final VoidCallback onRemove;

  const EmailChip({
    super.key,
    required this.email,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colorController.textColorLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: reusableText(email,color: colorController.blackColor,fontsize: 17)),
            // const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.close,),
            )
          ],
        ),
      ),
    );
  }
}


class AddEmailDialog extends StatefulWidget {
  const AddEmailDialog({super.key});

  @override
  State<AddEmailDialog> createState() => _AddEmailDialogState();
}

class _AddEmailDialogState extends State<AddEmailDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: reusableText('Add Email',color: colorController.blackColor,fontsize: 16),
      content: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter email address',
          fillColor: colorController.textColorLight,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          hintStyle: TextStyle(color: colorController.mainColor)
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: reusableText('Cancel',color: colorController.blackColor,fontsize: 14),
        ),
        ElevatedButton(
          onPressed: () =>
              Navigator.pop(context, controller.text.trim()),
          child: reusableText('Add',color: colorController.blackColor,fontsize: 14),
        ),
      ],
    );
  }
}
