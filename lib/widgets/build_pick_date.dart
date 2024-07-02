import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class BuildPickDate extends StatefulWidget {
  const BuildPickDate(
      {super.key,
      required this.title,
      this.required = false,
      required this.dateController});

  final String title;
  final bool required;
  final TextEditingController dateController;

  @override
  State<BuildPickDate> createState() => _BuildPickDateState();
}

class _BuildPickDateState extends State<BuildPickDate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            // padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.inputBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: TextStyle(
                color: AppColor.textTitle,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              controller: widget.dateController,
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              onTap: selectedDate,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                isCollapsed: true,
                prefixIcon: Icon(
                  Icons.date_range_rounded,
                  color: AppColor.textBody,
                ),
                hintText: 'Pick Date',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColor.textBody,
                  fontWeight: FontWeight.w400,
                )
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectedDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() {
        widget.dateController.text = selected.toString().split(" ")[0];
      });
    }
  }
}
