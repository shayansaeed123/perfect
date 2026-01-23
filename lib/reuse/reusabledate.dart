

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/color_controller.dart';

Widget reusableTodayDateField(
  BuildContext context,
  DateTime selectedDate,
  Widget icon,
  String hint,
) {
  final controller = TextEditingController(
    text: DateFormat('dd-MM-yyyy').format(selectedDate),
    // text: DateFormat('yyyy-MM-dd').format(selectedDate),
  );

  return TextFormField(
    controller: controller,
    readOnly: true, // ✅ user edit nahi kar sakta
    enabled: true,  // ✅ input look same rahega
    style: const TextStyle(fontSize: 12),
    decoration: InputDecoration(
          filled: true,
          fillColor: colorController.whiteColor,
          suffixIcon: icon,
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
  );
}


Widget reusableDate(
  BuildContext context,
  DateTime? selectedTime,
  Function(DateTime) selectdateontap,
  Widget icon,
  String hint, {
  bool enabled = true,
}) {
  final DateTime today = DateTime.now();

  final controller = TextEditingController(
    text: selectedTime == null
        // ? DateFormat('yyyy-MM-dd').format(today)
        ? ''
        : DateFormat('yyyy-MM-dd').format(selectedTime),
  );

  return InkWell(
    onTap: enabled
        ? () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedTime ?? today,
              firstDate: today,
              lastDate: today, // 👈 ONLY TODAY
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: ColorScheme.light(
                      primary: colorController.btnColor,
                      onPrimary: colorController.whiteColor,
                      onSurface: colorController.btnColor,
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (picked != null) {
              selectdateontap(picked);
            }
          }
        : null,
    child: IgnorePointer(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 12,
          color: enabled
              ? colorController.blackColor
              : colorController.grayTextColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: colorController.whiteColor,
          labelText: selectedTime != null ? hint : null,
          suffixIcon: icon,
          hintText: selectedTime == null ? hint : null, 
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
