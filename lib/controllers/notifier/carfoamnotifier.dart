import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/carfoammodel.dart';
import 'package:project/repo/utils.dart';

/// Global form state
final carFormProvider =
    StateNotifierProvider<CarFormNotifier, CarFormData>((ref) {
  return CarFormNotifier();
});

/// Loading flags (image uploading / final submit)
final loadingProvider = StateProvider<bool>((ref) => false);

class CarFormNotifier extends StateNotifier<CarFormData> {
  CarFormNotifier() : super(CarFormData());

  // ── Customer
  void updateCustomerDetails({
    String? requestedFor,
    String? customerName,
    String? inspectionDate,
    String? address,
    String? evaluationNo,
  }) {
    state = state.copyWith(
      requestedFor: requestedFor,
      customerName: customerName,
      inspectionDate: inspectionDate,
      address: address,
      evaluationNo: evaluationNo,
    );
  }

  // ── Car 1
  void updateCarDetails1({
    String? make,
    String? model,
    String? year,
    String? plateNo,
    String? vin,
    String? engineNo,
    String? color,
    String? fuelType,
    String? option,
  }) {
    state = state.copyWith(
      make: make,
      model: model,
      year: year,
      plateNo: plateNo,
      vin: vin,
      engineNo: engineNo,
      color: color,
      fuelType: fuelType,
      option: option,
    );
  }

  // ── Car 2
  void updateCarDetails2({
    String? trim,
    String? odometer,
    String? specification,
    String? bodyType,
    String? cylinders,
    String? transmission,
    String? carCondition,
  }) {
    state = state.copyWith(
      trim: trim,
      odometer: odometer,
      specification: specification,
      bodyType: bodyType,
      cylinders: cylinders,
      transmission: transmission,
      carCondition: carCondition,
    );
  }

  // ── Upload a single image to image.php and save returned URL/path
  Future<String?> _uploadImageToServer(File file, String fieldName) async {
    final request = http.MultipartRequest("POST", Uri.parse(Utils.imageUploadUrl));
    // server expects keys like 'car_front' / 'car_back'
    request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));

    final streamed = await request.send();
    final resp = await streamed.stream.bytesToString();

    if (streamed.statusCode == 200) {
      // Expected response sample (adjust if your API differs):
      // { "status": "success", "car_front": "uploads/abc.jpg" }
      final data = jsonDecode(resp);
      if (data is Map && data["status"] == "success") {
        return data[fieldName] as String?;
      }
    }
    return null;
  }

  /// Public method for UI to upload and store image URLs
  // Future<bool> uploadCarImage({File? profileimage1, File? profileimage2, File? profileimage3, File? profileimage4, File? profileimage5, File? profileimage6, File? profileimage7, File? profileimage8}) async {
  //   String? profile_image1 = state.profile_image1;
  //   String? profile_image2 = state.profile_image2;
  //   String? profile_image3 = state.profile_image3;
  //   String? profile_image4 = state.profile_image4;
  //   String? profile_image5 = state.profile_image5;
  //   String? profile_image6 = state.profile_image6;
  //   String? profile_image7 = state.profile_image7;
  //   String? profile_image8 = state.profile_image8;

  //   if (profileimage1 != null) {
  //     final p = await _uploadImageToServer(profileimage1, "profile_image1");
  //     if (p == null) return false;
  //     profile_image1 = p;
  //   }
  //   if (profileimage2 != null) {
  //     final p = await _uploadImageToServer(profileimage2, "car_back");
  //     if (p == null) return false;
  //     profile_image2 = p;
  //   }
  //   if (profileimage3 != null) {
  //     final p = await _uploadImageToServer(profileimage3, "car_back");
  //     if (p == null) return false;
  //     profile_image3 = p;
  //   }
  //   if (profileimage4 != null) {
  //     final p = await _uploadImageToServer(profileimage4, "car_back");
  //     if (p == null) return false;
  //     profile_image4 = p;
  //   }
  //   if (profileimage5 != null) {
  //     final p = await _uploadImageToServer(profileimage5, "car_back");
  //     if (p == null) return false;
  //     profile_image5 = p;
  //   }
  //   if (profileimage6 != null) {
  //     final p = await _uploadImageToServer(profileimage6, "car_back");
  //     if (p == null) return false;
  //     profile_image6 = p;
  //   }
  //   if (profileimage7 != null) {
  //     final p = await _uploadImageToServer(profileimage7, "car_back");
  //     if (p == null) return false;
  //     profile_image7 = p;
  //   }
  //   if (profileimage8 != null) {
  //     final p = await _uploadImageToServer(profileimage8, "car_back");
  //     if (p == null) return false;
  //     profile_image8 = p;
  //   }

  //   state = state.copyWith(
  //     profile_image1: profile_image1,
  //     profile_image2: profile_image2,
  //     profile_image3: profile_image3,
  //     profile_image4: profile_image4,
  //     profile_image5: profile_image5,
  //     profile_image6: profile_image6,
  //     profile_image7: profile_image7,
  //     profile_image8: profile_image8,
  //   );
  //   return true;
  // }

  Future<bool> uploadCarImage({
    File? profileimage1,
    File? profileimage2,
    File? profileimage3,
    File? profileimage4,
    File? profileimage5,
    File? profileimage6,
    File? profileimage7,
    File? profileimage8,
  }) async {
    try {
      var uri = Uri.parse("https://car.greenzoneliving.org/API/image.php");
      var request = http.MultipartRequest("POST", uri);

      Future<void> addFile(String field, File? file) async {
        if (file != null) {
          request.files.add(
            await http.MultipartFile.fromPath(field, file.path),
          );
        }
      }

      await addFile("profile_image1", profileimage1);
      await addFile("profile_image2", profileimage2);
      await addFile("profile_image3", profileimage3);
      await addFile("profile_image4", profileimage4);
      await addFile("profile_image5", profileimage5);
      await addFile("profile_image6", profileimage6);
      await addFile("profile_image7", profileimage7);
      await addFile("profile_image8", profileimage8);

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseString = await response.stream.bytesToString();
      final responseData = json.decode(responseString);
      debugPrint('Response Data: $responseData');
        debugPrint("✅ Images uploaded successfully");
        return true;
      } else {
        print('objectgfdsgdfhg ${response.toString()}');
        debugPrint("❌ Upload failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("UploadCarImage Error: $e");
      return false;
    }
  }

  /// Final API Call
  Future<bool> submitCarForm() async {
    try {
      
      final response = await http.post(
        Uri.parse("https://car.greenzoneliving.org/API/form_submit.php"),
        body: state.toJson(),
      );

      if (response.statusCode == 200) {
        debugPrint("✅ Submit Response: ${response.body}");
        return true;
      } else {
        debugPrint("❌ Failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("SubmitCarForm Error: $e");
      return false;
    }
  }
}
