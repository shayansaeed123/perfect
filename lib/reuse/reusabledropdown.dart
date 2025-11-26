

import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';

reusableDropdown<T>(
    List<T> items,
  T? selectedItem,
  String label,
  String Function(T) getLabel,
  Function(T?) onChanged,
  {
    bool enabled = true,
  }
  ){
    return DropdownButtonFormField<T>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: colorController.mainColor,fontSize: 12.5),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorController.textColorLight, width: 1.5)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorController.textColorLight, width: 1.5)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorController.mainColor, width: 1.5)
        ),
      ),
      value: items.contains(selectedItem) ? selectedItem : null,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: reusableText(getLabel(item), fontsize: 12.5),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
    );
  }