import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildDropdown extends StatefulWidget {
  const BuildDropdown({
    super.key,
    required this.selectedItem,
    required this.item,
    required this.hint,
    required this.title,
    required this.onChanged,
    this.enabled = true,
    this.spacingDropdown,
  });

  final String selectedItem;
  final String hint;
  final String title;
  final List<String> item;
  final ValueChanged<String?> onChanged;
  final bool enabled;
  final EdgeInsetsGeometry? spacingDropdown;

  @override
  State<BuildDropdown> createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;

    // Ensure selected item exists in the items list
    if (!widget.item.contains(selectedItem)) {
      selectedItem = '';
    }
  }

  @override
  void didUpdateWidget(covariant BuildDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.item != oldWidget.item ||
        widget.selectedItem != oldWidget.selectedItem) {
      setState(() {
        selectedItem = widget.item.contains(widget.selectedItem)
            ? widget.selectedItem
            : '';
      });
    }
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
          padding: widget.spacingDropdown ?? const EdgeInsets.only(top: 10, bottom: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.inputBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: const SizedBox(),
              iconEnabledColor: AppColor.textTitle,
              value: selectedItem.isEmpty ? null : selectedItem,
              isDense: true,
              items: widget.item.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: AppColor.textTitle,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: widget.enabled
                  ? (String? newValue) {
                      setState(() {
                        selectedItem = newValue ?? '';
                      });
                      widget.onChanged(newValue);
                    }
                  : null,
              hint: Text(
                widget.hint,
                style: TextStyle(color: Colors.grey[300]),
              ),
              dropdownColor: widget.enabled ? Colors.white : Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }
}
