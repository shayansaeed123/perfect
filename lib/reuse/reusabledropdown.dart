

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusabletext.dart';
import 'package:dropdown_search/dropdown_search.dart';

// reusableDropdown<T>(
//     List<T> items,
//   T? selectedItem,
//   String label,
//   String Function(T) getLabel,
//   Function(T?) onChanged,
//   {
//     bool enabled = true,
//   }
//   ){
//     return DropdownButtonFormField<T>(
//       isExpanded: true,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: colorController.mainColor,fontSize: 12.5),
//         isDense: true,
//         contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: colorController.textColorLight, width: 1.5)
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: colorController.textColorLight, width: 1.5)
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: colorController.mainColor, width: 1.5)
//         ),
//       ),
//       value: items.contains(selectedItem) ? selectedItem : null,
//       items: items.map((item) {
//         return DropdownMenuItem<T>(
//           value: item,
//           child: reusableText(getLabel(item), fontsize: 12.5),
//         );
//       }).toList(),
//       onChanged: enabled ? onChanged : null,
//     );
//   }




Widget reusableSearchableDropdown<T>(
  List<T> items,
  T? selectedItem,
  String label,
  String Function(T) getLabel,
  Function(T?) onChanged, {
  bool enabled = true,
}) {
  return DropdownSearch<T>(
    enabled: enabled,
    items: items,
    selectedItem: selectedItem,
    itemAsString: (item) => getLabel(item),
    onChanged: onChanged,
    popupProps: PopupProps.menu(
      showSearchBox: true,
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          hintText: "Search...",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    dropdownDecoratorProps: DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: colorController.mainColor, fontSize: 12.5),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: colorController.textColorLight, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: colorController.textColorLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: colorController.mainColor, width: 1.5),
        ),
      ),
    ),
  );
}




Widget reusableDropdown<T>(
  BuildContext context,
  List<T> items,
  T? selectedItem,
  String label,
  String Function(T) getLabel,
  Function(T?) onChanged, {
  bool enabled = true,
}) {
  int initialIndex =
      selectedItem != null ? items.indexOf(selectedItem) : 0;
      int tempSelectedIndex = initialIndex < 0 ? 0 : initialIndex;

  void openPicker() {
    FocusScope.of(context).unfocus();
    showCupertinoModalBottomSheet(
      context: context,
      topRadius: const Radius.circular(16),
      backgroundColor: colorController.whiteColor,
      builder: (_) {
        return Material(
          color: colorController.whiteColor,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.35,
            child: Column(
              children: [
                // Header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: colorController.mainColor,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onChanged(items[tempSelectedIndex]);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: colorController.mainColor,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
          
                const Divider(height: 1),
          
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 36,
                    magnification: 1.05,
                    useMagnifier: true,
                    scrollController: FixedExtentScrollController(
                      initialItem: tempSelectedIndex,
                    ),
                    onSelectedItemChanged: (index) {
                      tempSelectedIndex = index; // 👈 temp store
                    },
                    children: items
                        .map(
                          (e) => Center(
                            child: Text(
                              getLabel(e),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  return GestureDetector(
    onTap: enabled ? openPicker : null,
    child: AbsorbPointer(
      child: TextFormField(
        style: TextStyle(fontSize: 12.5,color: Colors.black54),
        readOnly: true,
        controller: TextEditingController(
          text: selectedItem != null ? getLabel(selectedItem) : '',
        ),
        decoration: 
          InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(color: colorController.mainColor, fontSize: 12.5),
        isDense: true,
        suffixIcon: const Icon(Icons.keyboard_arrow_down),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: colorController.textColorLight, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: colorController.textColorLight, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: colorController.mainColor, width: 1.5),
        ),
      ),
      ),
    ),
  );
}