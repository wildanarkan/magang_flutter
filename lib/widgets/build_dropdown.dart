import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildDropdown extends StatefulWidget {
  const BuildDropdown({
    super.key,
    required this.selectedItem,
    required this.item,
    required this.hint,
    required this.title,
  });

  final String selectedItem;
  final String hint;
  final String title;
  final List<String> item;

  @override
  State<BuildDropdown> createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.textBody,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.inputBackground,
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              iconEnabledColor: AppColor.textTitle,
              value: selectedItem,
              isDense: true,
              items: widget.item.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(
                    color: AppColor.textTitle,
                fontWeight: FontWeight.w500,
                fontSize: 14
                  ),),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue ?? selectedItem;
                });
              },
              hint: Text(widget.hint), // Memanggil hint di sini
            ),
          ),
        ),
      ],
    );
  }
}
