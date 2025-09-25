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
    String? bankName,
    String? customerName,
    String? inspectionDate,
    String? address,
    // String? evaluationNo,
  }) {
    state = state.copyWith(
      requestedFor: requestedFor,
      bankName: bankName,
      customerName: customerName,
      inspectionDate: inspectionDate,
      address: address,
      // evaluationNo: evaluationNo,
    );
  }

  // ── Car 1
  void updateCarDetails1({
    String? make,
    String? model,
    String? year,
    String? trim,
    String? plateNo,
    String? odometer,
    String? odometerUnit,
    String? vin,
    String? specification,
    String? engineNo,
  }) {
    state = state.copyWith(
      make: make,
      model: model,
      year: year,
      trim: trim,
      plateNo: plateNo,
      odometer: odometer,
      odometerUnit: odometerUnit,
      vin: vin,
      specification: specification,
      engineNo: engineNo,
    );
  }

  // ── Car 2
  void updateCarDetails2({
    
    
    
    String? bodyType,
    String? color,
    String? cylinders,
    String? fuelType,
    String? transmission,
    String? option,
    String? carCondition,
    String? total,
    String? enterby,
  }) {
    state = state.copyWith(
      bodyType: bodyType,
      color: color,
      cylinders: cylinders,
      fuelType: fuelType,
      transmission: transmission,
      option: option,
      carCondition: carCondition,
      total: total,
      enterby: enterby,
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

  /// 🔹 Update Image Paths in State
  void updateCarImages(String imageType, String path) {
    switch (imageType) {
      case 'profile_image1': state = state.copyWith(profile_image1: path); break;
      case 'profile_image2': state = state.copyWith(profile_image2: path); break;
      case 'profile_image3': state = state.copyWith(profile_image3: path); break;
      case 'profile_image4': state = state.copyWith(profile_image4: path); break;
      case 'profile_image5': state = state.copyWith(profile_image5: path); break;
      case 'profile_image6': state = state.copyWith(profile_image6: path); break;
      case 'profile_image7': state = state.copyWith(profile_image7: path); break;
      case 'profile_image8': state = state.copyWith(profile_image8: path); break;
    }
  }

  /// ✅ Image Upload Function
  Future<String?> uploadCarImage(File file, String fieldName) async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(Utils.imageUploadUrl),
      );

      // ✅ send with correct field name
      request.files.add(
        await http.MultipartFile.fromPath(fieldName, file.path),
      );

      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      debugPrint("📷 Upload Response: $respStr");

      if (response.statusCode == 200) {
      final data = jsonDecode(respStr);

      // ✅ server response is { "profile_image1": "uploaded_url" }
      if (data[fieldName] != null) {
        final uploadedPath = data[fieldName];
        updateCarImages(fieldName, uploadedPath);
        return uploadedPath;
      } else {
        debugPrint("❌ Upload failed: $data");
        return null;
      }
    } else {
      debugPrint("❌ Upload failed ${response.statusCode}");
      return null;
    }
    } catch (e) {
      debugPrint("Upload Error: $e");
      return null;
    }
  }

  /// 🔹 Final Submit API
  Future<bool> submitCarForm() async {
    try {
      final response = await http.post(
        Uri.parse(Utils.formSubmitUrl),
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

  void resetForm() {
  state = CarFormData(
    requestedFor: '',
    customerName: '',
    inspectionDate: '',
    address: '',
    // evaluationNo: '',
    bankName: '',
    make: '',
    model: '',
    year: '',
    plateNo: '',
    vin: '',
    engineNo: '',
    color: '',
    fuelType: '',
    option: '',
    trim: '',
    odometer: '',
    odometerUnit: '',
    specification: '',
    bodyType: '',
    cylinders: '',
    transmission: '',
    carCondition: '',
    total: '',
    enterby: '',
    profile_image1: null,
    profile_image2: null,
    profile_image3: null,
    profile_image4: null,
    profile_image5: null,
    profile_image6: null,
    profile_image7: null,
    profile_image8: null,
  );
}

  // Future<bool> uploadCarImage({
  //   File? profileimage1,
  //   File? profileimage2,
  //   File? profileimage3,
  //   File? profileimage4,
  //   File? profileimage5,
  //   File? profileimage6,
  //   File? profileimage7,
  //   File? profileimage8,
  // }) async {
  //   try {
  //     var uri = Uri.parse("${Utils.imageUploadUrl}");
  //     var request = http.MultipartRequest("POST", uri);

  //     Future<void> addFile(String field, File? file) async {
  //       if (file != null) {
  //         request.files.add(
  //           await http.MultipartFile.fromPath(field, file.path),
  //         );
  //       }
  //     }

  //     await addFile("profile_image1", profileimage1);
  //     await addFile("profile_image2", profileimage2);
  //     await addFile("profile_image3", profileimage3);
  //     await addFile("profile_image4", profileimage4);
  //     await addFile("profile_image5", profileimage5);
  //     await addFile("profile_image6", profileimage6);
  //     await addFile("profile_image7", profileimage7);
  //     await addFile("profile_image8", profileimage8);
  //     // await addFile("image1", profileimage1);
  //     // await addFile("image2", profileimage2);
  //     // await addFile("image3", profileimage3);
  //     // await addFile("image4", profileimage4);
  //     // await addFile("image5", profileimage5);
  //     // await addFile("image6", profileimage6);
  //     // await addFile("image7", profileimage7);
  //     // await addFile("image8", profileimage8);

  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       final responseString = await response.stream.bytesToString();
  //     final responseData = json.decode(responseString);
  //     debugPrint('Response Data: $responseData');
  //       debugPrint("✅ Images uploaded successfully");
  //       return true;
  //     } else {
  //       print('objectgfdsgdfhg ${response.toString()}');
  //       debugPrint("❌ Upload failed: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint("UploadCarImage Error: $e");
  //     return false;
  //   }
  // }

  // /// Final API Call
  // Future<bool> submitCarForm() async {
  //   try {
      
  //     final response = await http.post(
  //       Uri.parse("${Utils.formSubmitUrl}"),
  //       body: state.toJson(),
  //     );

  //     if (response.statusCode == 200) {
  //       debugPrint("✅ Submit Response: ${response.body}");
  //       return true;
  //     } else {
  //       debugPrint("❌ Failed: ${response.statusCode}");
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint("SubmitCarForm Error: $e");
  //     return false;
  //   }
  // }
}
