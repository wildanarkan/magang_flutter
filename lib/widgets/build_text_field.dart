import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildTextField extends StatefulWidget {
  const BuildTextField({
    super.key,
    required this.title,
    this.required = false,
    this.hintText,
    this.controller,
    this.onChanged,
  });

  final String title;
  final TextEditingController? controller;
  final bool required;
  final String? hintText;
  final Function(String)? onChanged;

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
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
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: widget.controller,
              style: TextStyle(
                  color: AppColor.textTitle,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: AppColor.textBody
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
