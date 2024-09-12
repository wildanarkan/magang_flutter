import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildFieldText extends StatefulWidget {
  const BuildFieldText({
    super.key,
    required this.title,
    this.required = false,
    this.hintText,
    this.controller,
    this.value, // Tambahkan parameter value
    this.onChanged,
    this.readOnly, this.inputType, this.obscureText,
  });

  final String title;
  final TextEditingController? controller;
  final bool required;
  final bool? readOnly;
  final bool? obscureText;
  final String? hintText;
  final Function(String)? onChanged;
  final String? value; // Tambahkan parameter value
  final TextInputType? inputType;

  @override
  State<BuildFieldText> createState() => _BuildFieldTextState();
}

class _BuildFieldTextState extends State<BuildFieldText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColor.textBody,
              ),
            ),
            if (widget.required == true)
              const Text(
                ' (*)',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.inputBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              readOnly: widget.readOnly ?? false,
              obscureText: widget.obscureText ?? false,
              keyboardType: widget.inputType,
              controller: widget.controller ?? TextEditingController(text: widget.value), // Gunakan value jika controller tidak ada
              style: TextStyle(
                color: AppColor.textTitle,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: AppColor.textBody,
                ),
                hintText: widget.hintText,
                isDense: true,
                isCollapsed: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
