

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableDate(
  BuildContext context,
  DateTime lastDate,
  DateTime? selectedTime,
  Function(DateTime) selectdateontap,
  Widget icon,
  String hint,
  {
  bool enabled = true,
}
) {
  final controller = TextEditingController(
    text: selectedTime == null
        ? ''
        : DateFormat('yyyy-MM-dd').format(selectedTime),
  );

  return InkWell(
    onTap: enabled ? () async {
      final DateTime initialDate =
          (selectedTime != null && !selectedTime.isBefore(lastDate))
              ? selectedTime
              : DateTime.now();

      final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: lastDate,
        lastDate: DateTime.now(),
        initialDate: initialDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: colorController.btnColor,
                onPrimary: colorController.whiteColor,
                onSurface: colorController.btnColor,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        selectdateontap(picked);
      }
    } : null,
    child: IgnorePointer(
      // ignoring: !enabled,
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 12.0,color: enabled ? colorController.blackColor : colorController.grayTextColor,),
        decoration: InputDecoration(
          filled: true,
          fillColor: colorController.whiteColor,
          labelText: selectedTime != null ? hint : null, // Float only if date is selected
          suffixIcon: icon,
          hintText: selectedTime == null ? hint : null, // Show hint only if no date
          hintStyle: TextStyle(
            color: colorController.textfieldBorderColorBefore,
            fontSize: 11,
          ),
          labelStyle: TextStyle(
            color: colorController.textfieldBorderColorBefore,
            fontSize: 11.5,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorBefore,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorBefore,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: colorController.textfieldBorderColorAfter,
              width: 1.5,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
        ),
      ),
    ),
  );
}